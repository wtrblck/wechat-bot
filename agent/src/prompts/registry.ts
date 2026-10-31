import { readFileSync, realpathSync } from 'node:fs';
import { isAbsolute, relative, resolve } from 'node:path';
import type { Config } from '../config.js';
import { conversationConfig } from '../config.js';
import { hash, type HostInput, type Session } from '../contracts.js';
import type { Store } from '../storage/database.js';

const defaults: Record<string, string | null> = {
  system: 'prompts/base.md', persona: 'prompts/personas/default.md', groupScene: 'prompts/group.md',
  directScene: 'prompts/direct.md', responseStyle: 'prompts/styles/default.md', participation: 'prompts/participation/helpful.md',
  replyDecision: 'prompts/reply-decision.md', toolBehavior: 'prompts/tools/default.md',
  memoryExtract: 'prompts/memory/extract.md', memoryConsolidate: 'prompts/memory/consolidate.md', sessionCompact: 'prompts/compact/default.md',
};
export class PromptRegistry {
  private sources = new Map<string, string>();
  reloadError: string | null = null;
  constructor(readonly config: Config) { this.validateAll(); }
  private profile(name: string, stack: string[] = []): Record<string, any> {
    if (stack.includes(name) || stack.length >= 8) throw Error('prompt_profile_cycle');
    const value = this.config.promptProfiles[name];
    if (!value) { if (name === 'default') return {}; throw Error('unknown_prompt_profile'); }
    const { extends: parent, ...own } = value;
    return { ...(parent ? this.profile(parent, [...stack, name]) : {}), ...own };
  }
  effective(session: Pick<Session, 'scope' | 'conversation' | 'persona'>) {
    const override = conversationConfig(this.config, session.scope, session.conversation)?.prompts;
    const profile = override?.profile ?? this.config.prompts.profile ?? 'default';
    const value: Record<string, any> = { ...defaults, ...this.profile(profile), ...this.config.prompts,
      ...(override?.profile ? this.profile(override.profile) : {}), ...override };
    if (session.persona) value.persona = this.profile(session.persona).persona ?? value.persona;
    return value;
  }
  private readTemplate(path: string): string {
    const full = realpathSync(resolve(this.config.root, path));
    const rel = relative(this.config.root, full);
    if (rel.startsWith('..') || isAbsolute(rel)) throw Error('prompt_path_outside_root');
    const source = readFileSync(full, 'utf8');
    if (Buffer.byteLength(source) > 16000) throw Error('prompt_too_large');
    return source;
  }
  private template(path: string) { const value = this.sources.get(path); if (value === undefined) throw Error('template_not_validated'); return value; }
  private render(source: string, scope: string) {
    const vars: Record<string, string> = { bot_name: '小鲸鱼', conversation_kind: scope, language: '中文',
      local_time: new Date().toLocaleString('sv-SE', { timeZone: 'Asia/Shanghai' }) + ' Asia/Shanghai' };
    return source.replace(/\\\{\{/g, '\u0001').replace(/\{\{\s*([\w]+)\s*\}\}/g, (_, key: string) => {
      if (!(key in vars)) throw Error('unknown_prompt_variable:' + key); return vars[key]!;
    }).replace(/\u0001/g, '{{');
  }
  validateAll() {
    const next = new Map<string, string>();
    for (const name of Object.keys(this.config.promptProfiles)) this.profile(name);
    const scopes = [
      { scope: 'direct' as const, conversation: '', persona: null },
      ...Object.keys(this.config.conversationOverrides.groups).map(conversation => ({ scope: 'group' as const, conversation, persona: null })),
      ...Object.keys(this.config.conversationOverrides.contacts).map(conversation => ({ scope: 'direct' as const, conversation, persona: null })),
    ];
    const values = [...scopes.map(s => this.effective(s)), ...Object.keys(this.config.promptProfiles).map(p => ({ ...defaults, ...this.profile(p) }))];
    for (const value of values) for (const [key, path] of Object.entries(value)) {
      if (!(key in defaults)) continue;
      if (path === null) { if (!['persona', 'toolBehavior'].includes(key)) throw Error('required_prompt_disabled'); continue; }
      const source = this.readTemplate(path as string);
      this.render(source, 'direct'); next.set(path as string, source);
    }
    this.sources = next;
  }
  snapshot(session: Session, purpose: HostInput['purpose'], store?: Store) {
    try { this.validateAll(); this.reloadError = null; }
    catch { if (!this.sources.size) throw Error('no_valid_prompt_version'); this.reloadError = 'prompt_reload_rejected'; }
    const effective = this.effective(session);
    const types = purpose === 'decision' ? ['replyDecision', 'participation'] : purpose === 'memory' ?
      ['memoryExtract', 'memoryConsolidate'] : ['system', 'persona', session.scope === 'group' ? 'groupScene' : 'directScene', 'responseStyle', 'participation', 'toolBehavior'];
    const sections = types.filter(t => effective[t] !== null).map(type => {
      const source = this.template(effective[type]);
      return { type, source: effective[type], hash: hash(source), role: 'system', text: this.render(source, session.scope) };
    });
    if (purpose === 'reply' && effective.append) sections.push({ type: 'append', source: 'config', hash: hash(effective.append), role: 'system', text: effective.append });
    const system = sections.map(s => s.text).join('\n\n');
    if (Buffer.byteLength(system) > 32000) throw Error('effective_prompt_too_large');
    const id = hash([this.config.version, session.key, purpose, sections]);
    const snapshot = { id, purpose, sections, estimatedTokensUpperBound: Buffer.byteLength(system), contextScope: session.key };
    store?.exec('INSERT OR IGNORE INTO prompt_snapshots VALUES(?,?,?,?,?)', id, session.key, hash(this.config.version), JSON.stringify(snapshot), store.clock());
    return { ...snapshot, system };
  }
}
