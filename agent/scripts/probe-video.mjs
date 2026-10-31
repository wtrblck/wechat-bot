import { loadConfig } from '../dist/src/config.js';
import { VideoService } from '../dist/src/media/video.js';
import { mkdirSync, writeFileSync, rmSync } from 'node:fs';
import { resolve } from 'node:path';
import { randomUUID } from 'node:crypto';

const config = loadConfig(resolve('config/agent.local.yaml'));
const scope = 'video-probe-' + randomUUID();
const service = new VideoService(config, scope);
const platform = process.argv[2] ?? 'bilibili';
if (!['bilibili', 'douyin', 'direct'].includes(platform)) throw Error('invalid_platform');
const url = process.argv[3] ?? (platform === 'douyin' ? 'https://www.douyin.com/video/6961737553342991651' : 'https://www.bilibili.com/video/BV1d8pU6xEZX');
let stage = 'acquire';
try {
  const { bytes, ...result } = await service.acquire(url, platform, AbortSignal.timeout(100000));
  const path = 'probe.mp4'; service.sandbox.writeBytes(path, bytes, config.video.maxInputMiB * 1048576);
  stage = 'storyboard';
  const board = await service.board(path, 0, Math.min(15, result.metadata.duration), AbortSignal.timeout(90000));
  const directory = resolve(config.root, 'data/validation'); mkdirSync(directory, { recursive: true });
  writeFileSync(resolve(directory, `video-${platform}-storyboard.jpg`), board.bytes);
  stage = 'transcript';
  const transcript = await service.transcript(path, 0, 30, AbortSignal.timeout(90000));
  const report = { platform, acquired: true, bytes: bytes.length, ...result, board: board.manifest, transcript };
  writeFileSync(resolve(directory, `video-${platform}.json`), JSON.stringify(report, null, 2));
  console.log(JSON.stringify({ platform, acquired: true, bytes: bytes.length, metadata: result.metadata,
    frames: board.manifest.cells.length, transcriptState: transcript.state }));
} catch (error) {
  console.log(JSON.stringify({ platform, acquired: stage !== 'acquire', stage, error: error.message })); process.exitCode = 1;
} finally { rmSync(service.sandbox.root, { recursive: true, force: true }); }
