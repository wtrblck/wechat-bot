param(
    [switch]$Check,
    [ValidateRange(0, 86400)][int]$Seconds = 0
)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
# Keep native helper extraction on the project's drive. A full system TEMP
# otherwise prevents the bridge from attaching even when project storage is free.
$bridgeTemp = Join-Path $projectRoot 'weixin-research/runs/runtime-temp'
New-Item -ItemType Directory -Path $bridgeTemp -Force | Out-Null
$env:TEMP = $bridgeTemp
$env:TMP = $bridgeTemp
$policyPath = Join-Path $projectRoot 'weixin-research/runs/bridge-policy.local.json'
$configPath = Join-Path $projectRoot 'weixin-research/runs/bridge.local.json'
if (!(Test-Path -LiteralPath $policyPath) -or !(Test-Path -LiteralPath $configPath)) {
    throw '本地桥接配置尚未生成。'
}
# Load policy in the same Python interpreter as the service: PS5 erases empty environment values.
$bridgeArguments = @('-3.14', (Join-Path $projectRoot 'weixin-research/run_bridge.py'), '--policy', $policyPath, '--config', $configPath)
if ($Check) { $bridgeArguments += '--check' }
if ($Seconds -gt 0) { $bridgeArguments += @('--seconds', [string]$Seconds) }
& py @bridgeArguments
if ($LASTEXITCODE -ne 0) { throw "桥接程序退出，代码：$LASTEXITCODE" }
