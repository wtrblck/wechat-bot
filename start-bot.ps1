param(
    [switch]$Check,
    [switch]$Status,
    [ValidateRange(10, 300)][int]$TimeoutSeconds = 90
)
$ErrorActionPreference = 'Stop'
$projectRoot = $PSScriptRoot
$agentRoot = Join-Path $projectRoot 'agent'
$statusHelper = Join-Path $agentRoot 'scripts/bot-status.mjs'
$launcherLog = $null
$startupMutex = $null
$ownsMutex = $false

function Write-StartupMessage([string]$Message) {
    Write-Host $Message
    if ($launcherLog) { Add-Content -LiteralPath $launcherLog -Value ((Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + ' ' + $Message) -Encoding UTF8 }
}
function Get-BotSnapshot {
    $raw = & $nodePath $statusHelper
    if ($LASTEXITCODE -ne 0) { throw '无法读取运行状态；为避免重复启动，已停止。' }
    $snapshot = ($raw -join "`n") | ConvertFrom-Json
    if ($snapshot.error) { throw '无法读取运行状态；请检查本地配置和数据库。' }
    return $snapshot
}
function Start-HiddenComponent([string]$Script, [string]$Label) {
    $arguments = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', ('"' + $Script + '"'))
    $child = Start-Process -FilePath $shellPath -ArgumentList $arguments -WorkingDirectory $projectRoot -WindowStyle Hidden `
        -RedirectStandardOutput (Join-Path $runLogs ($Label + '.out.log')) `
        -RedirectStandardError (Join-Path $runLogs ($Label + '.err.log')) -PassThru
    Write-StartupMessage ($Label + ' 已创建后台进程：' + $child.Id)
    return $child
}

Push-Location -LiteralPath $agentRoot
try {
    $nodePath = (Get-Command node.exe -ErrorAction Stop).Source
    $shellCommand = Get-Command pwsh.exe -ErrorAction SilentlyContinue
    if (!$shellCommand) { $shellCommand = Get-Command powershell.exe -ErrorAction Stop }
    $shellPath = $shellCommand.Source
    if ($Status) {
        Get-BotSnapshot | ConvertTo-Json -Depth 5
        exit 0
    }
    if (!$Check) {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal($identity)
        if (!$principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
            Write-Host '连接微信需要管理员权限，正在请求提升权限。'
            $arguments = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', ('"' + $PSCommandPath + '"'), '-TimeoutSeconds', [string]$TimeoutSeconds)
            $elevated = Start-Process -FilePath $shellPath -ArgumentList $arguments -WorkingDirectory $projectRoot -Verb RunAs -WindowStyle Hidden -Wait -PassThru
            if ($elevated.ExitCode -ne 0) { throw '启动未完成。请查看 agent/data/startup 下最新日志。' }
            Get-BotSnapshot | ConvertTo-Json -Depth 5
            exit 0
        }
        $hasher = [Security.Cryptography.SHA256]::Create()
        try { $key = ([BitConverter]::ToString($hasher.ComputeHash([Text.Encoding]::UTF8.GetBytes($projectRoot)))).Replace('-', '').Substring(0, 16) }
        finally { $hasher.Dispose() }
        $startupMutex = New-Object Threading.Mutex($false, ('Local\WechatBotStartup-' + $key))
        try { $ownsMutex = $startupMutex.WaitOne(0) } catch [Threading.AbandonedMutexException] { $ownsMutex = $true }
        if (!$ownsMutex) { throw '已有启动过程正在进行，请稍候查看状态，不要重复点击。' }
        $existing = Get-BotSnapshot
        if ($existing.agent.running) {
            if ($existing.agent.started -and $existing.bridge.ready) { Write-Host ('bot 已启动，当前状态：' + $existing.agent.state + '，无需重复启动。'); exit 0 }
            throw ('已有 bot 实例，当前状态：' + $existing.agent.state + '。请先处理现有实例，未重复启动。')
        }
        $runLogs = Join-Path $agentRoot ('data/startup/' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '-' + $PID)
        New-Item -ItemType Directory -Path $runLogs -Force | Out-Null
        $launcherLog = Join-Path $runLogs 'startup.log'
        Write-StartupMessage ('启动日志：' + $runLogs)
    }
    Write-StartupMessage '检查依赖、编译代码并验证本地配置……'
    # Avoid node -e: Windows PowerShell 5 removes embedded quotes from native arguments.
    $nodeVersionText = (& $nodePath --version | Out-String).Trim()
    if ($LASTEXITCODE -ne 0) { throw '无法执行 Node.js，请检查安装。' }
    $nodeVersion = [Version]$nodeVersionText.TrimStart('v')
    if ($nodeVersion.Major -ne 24 -or $nodeVersion.Minor -lt 22) {
        throw ('本项目需要 Node.js 24.22 或更新的 24.x 版本，当前为：' + $nodeVersionText)
    }
    & pnpm build
    if ($LASTEXITCODE -ne 0) { throw '编译失败，尚未启动新服务。' }
    & (Join-Path $agentRoot 'start-agent.ps1') -Check | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'bot 配置检查失败。' }
    & (Join-Path $agentRoot 'start-bridge.ps1') -Check | Out-Null
    if ($LASTEXITCODE -ne 0) { throw '微信桥接配置检查失败。' }
    if ($Check) { Write-Host '检查通过，未启动 bot、桥接或 Web。'; exit 0 }
    if (!(Get-Process Weixin -ErrorAction SilentlyContinue)) { throw '请先打开电脑版微信并登录，再运行此脚本。' }

    $snapshot = Get-BotSnapshot
    $bridgeProcess = $null
    if (!$snapshot.bridge.reachable) {
        $bridgeProcess = Start-HiddenComponent (Join-Path $agentRoot 'start-bridge.ps1') 'bridge'
    } else { Write-StartupMessage '复用已运行的微信桥接，等待就绪。' }
    $timer = [Diagnostics.Stopwatch]::StartNew()
    while (!$snapshot.bridge.ready) {
        if ($bridgeProcess -and $bridgeProcess.HasExited) { throw '桥接启动后已退出，请查看本次 bridge.err.log。' }
        if ($timer.Elapsed.TotalSeconds -gt $TimeoutSeconds) { throw '微信桥接未能就绪。请确认微信已登录，并查看 bridge 日志。' }
        Start-Sleep -Milliseconds 1000
        $snapshot = Get-BotSnapshot
    }
    Write-StartupMessage '微信桥接收发已就绪。'
    # Recheck after waiting: a separately launched bot may have acquired the consumer lease.
    $snapshot = Get-BotSnapshot
    if (!$snapshot.agent.running) { $agentProcess = Start-HiddenComponent (Join-Path $agentRoot 'start-agent.ps1') 'agent' }
    else { $agentProcess = $null; Write-StartupMessage '发现已运行的 bot，复用现有实例。' }
    $timer.Restart()
    while (!$snapshot.agent.started) {
        if ($agentProcess -and $agentProcess.HasExited) { throw 'bot 启动后已退出，请查看本次 agent.err.log。' }
        if ($snapshot.agent.running -and $snapshot.agent.state -in @('paused_gap', 'budget_exhausted', 'budget_blocked', 'blocked')) {
            throw ('bot 已运行但暂停：' + $snapshot.agent.state + '。请处理原因后再启动。')
        }
        if (@($snapshot.agent.diagnostics) -contains 'autonomous_group_requires_empty_observe_prefix') {
            throw '群聊自主参与要求桥接观察前缀为空；当前桥接策略不匹配。请检查本次桥接配置，不能仅重开bot。'
        }
        if ($timer.Elapsed.TotalSeconds -gt $TimeoutSeconds) { throw 'bot 尚未就绪，请查看 agent 日志及 -Status 输出。' }
        Start-Sleep -Milliseconds 1000
        $snapshot = Get-BotSnapshot
    }
    if ($snapshot.agent.ready) { Write-StartupMessage 'bot 已就绪并在后台运行。可以关闭此启动窗口；本脚本不启动 dsh Web。' }
    else { Write-StartupMessage ('bot 已启动，因预算暂停模型调用：' + $snapshot.agent.state + '。请在管理页查看预算；无需反复启动。') }
    Write-StartupMessage ('日志目录：' + $runLogs)
} catch {
    Write-StartupMessage ('启动失败：' + $_.Exception.Message)
    Write-Host '已启动的组件会保留以便查看日志；再次运行会检查并复用，避免重复实例。'
    exit 1
} finally {
    if ($ownsMutex -and $startupMutex) { $startupMutex.ReleaseMutex() }
    if ($startupMutex) { $startupMutex.Dispose() }
    Pop-Location
}
