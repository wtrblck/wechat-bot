param([switch]$Check)
$ErrorActionPreference = 'Stop'
$configPath = Join-Path $PSScriptRoot 'config/agent.local.yaml'
if (!(Test-Path -LiteralPath $configPath)) { throw '智能体本地配置不存在。' }
$previousDshHome = [Environment]::GetEnvironmentVariable('DSH_HOME', 'Process')
$previousAgentConfig = [Environment]::GetEnvironmentVariable('WECHAT_AGENT_CONFIG', 'Process')
Push-Location -LiteralPath $PSScriptRoot
try {
    $env:DSH_HOME = Join-Path $PSScriptRoot 'data/dsh-home'
    $env:WECHAT_AGENT_CONFIG = $configPath
    if ($Check) {
        & node dist/src/cli.js check $configPath
        if ($LASTEXITCODE -ne 0) { throw '智能体配置检查失败。' }
        & pnpm exec dsh --profile wechat --dump-config
    }
    else { & pnpm exec dsh --profile wechat }
    if ($LASTEXITCODE -ne 0) { throw "智能体退出，代码：$LASTEXITCODE" }
}
finally {
    [Environment]::SetEnvironmentVariable('DSH_HOME', $previousDshHome, 'Process')
    [Environment]::SetEnvironmentVariable('WECHAT_AGENT_CONFIG', $previousAgentConfig, 'Process')
    Pop-Location
}
