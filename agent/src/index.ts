import type { Context } from '@deepseek-ai/cordis';
import { resolve } from 'node:path';
import { loadConfig } from './config.js';
import { Store } from './storage/database.js';
import { BridgeClient } from './bridge/client.js';
import { DshHostAdapter } from './runtime/host-adapter.js';
import { Engine } from './engine.js';
import { channelTools } from './tools/channel-tools.js';

export const name = 'wechat-agent';
export const inject = ['llm', 'attachments', 'agents', 'sessionPersistence', 'sessions', 'tools', 'systemPrompt', 'agentLoop'];
export async function apply(ctx: Context, options: { configFile?: string } = {}) {
  const config = loadConfig(resolve(options.configFile ?? process.env.WECHAT_AGENT_CONFIG ?? 'config/agent.local.yaml'));
  const store = new Store(config);
  let engine: Engine;
  try {
    const host = new DshHostAdapter(ctx, config);
    engine = new Engine(config, store, new BridgeClient(config), host);
    host.channelTools = (input, signal) => channelTools(engine, input, signal);
  }
  catch (error) { store.close(); throw error; }
  ctx.effect(() => () => engine.close());
  await engine.start();
}
