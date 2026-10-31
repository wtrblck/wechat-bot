$ErrorActionPreference = 'Stop'
Push-Location (Split-Path $PSScriptRoot)
try {
  & py -3.14 -m pip install --target tools/video-python -r scripts/video-requirements.txt
  if ($LASTEXITCODE -ne 0) { throw '视频组件安装失败' }
  & py -3.14 scripts/setup-video-model.py
  if ($LASTEXITCODE -ne 0) { throw '本地视频转写模型安装失败' }
  & py -3.14 scripts/video-worker.py '{"action":"health"}'
  if ($LASTEXITCODE -ne 0) { throw '视频组件检查失败' }
} finally { Pop-Location }
