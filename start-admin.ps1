param(
    [ValidateRange(1024, 65535)][int]$Port = 8788,
    [switch]$Check
)
$ErrorActionPreference = 'Stop'
$agentRoot = Join-Path $PSScriptRoot 'agent'
Push-Location -LiteralPath $agentRoot
try {
    if (!$Check) {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal($identity)
        if (!$principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
            Write-Host 'Service control requires administrator rights. Requesting elevation...'
            $shell = (Get-Command powershell.exe -ErrorAction Stop).Source
            $arguments = @('-NoProfile','-ExecutionPolicy','Bypass','-File',('"' + $PSCommandPath + '"'),'-Port',[string]$Port)
            $child = Start-Process -FilePath $shell -ArgumentList $arguments -WorkingDirectory $PSScriptRoot -Verb RunAs -WindowStyle Hidden -PassThru -Wait
            exit $child.ExitCode
        }
    }
    $nodePath = (Get-Command node.exe -ErrorAction Stop).Source
    $versionText = (& $nodePath --version | Out-String).Trim()
    if ($LASTEXITCODE -ne 0) { throw 'Cannot run Node.js.' }
    $version = [Version]$versionText.TrimStart('v')
    if ($version.Major -ne 24 -or $version.Minor -lt 22) {
        throw ('Node.js 24.22 or newer 24.x is required. Found: ' + $versionText)
    }
    & pnpm build
    if ($LASTEXITCODE -ne 0) { throw 'Build failed. No admin server was started.' }
    if ($Check) {
        Write-Host 'Build passed. No bot, bridge or admin server was started.'
        exit 0
    }
    Write-Host ('Local message console: http://127.0.0.1:' + $Port)
    Write-Host 'Use the web buttons to start or stop the bot and WeChat bridge. Opening this console alone does not start them.'
    Write-Host 'Keep this window open. Press Ctrl+C to stop only this console.'
    & $nodePath 'dist/src/admin-cli.js' 'config/agent.local.yaml' '--port' ([string]$Port)
    if ($LASTEXITCODE -ne 0) { throw ('Admin server exited with code ' + $LASTEXITCODE) }
} catch {
    Write-Error $_.Exception.Message
    exit 1
} finally {
    Pop-Location
}
