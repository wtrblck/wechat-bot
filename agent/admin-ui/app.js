'use strict';

(() => {
  const $ = (id) => document.getElementById(id);
  const PAGE_SIZE = 50;
  const state = {
    view: 'messages', messages: [], total: 0, offset: 0, query: '', status: '',
    selectedId: null, detail: null, detailFingerprint: '', overview: null, overviewFingerprint: '', queryPending: false,
    stickers: [], stickerTotal: 0, stickerOffset: 0, stickerQuery: '', stickerFingerprint: '',
    requests: new Map(), failures: new Map(), loaded: new Set(), lastSuccess: null,
    timer: null, polling: false, queryTimer: null, stickerTimer: null,
    services: null, serviceSubmitting: false,
    thumbnailQueue: [], thumbnailJobs: 0, thumbnailGeneration: 0,
  };
  const STATUS = {
    received: ['已收到', 'active', '↓'], processing: ['处理中', 'active', '◌'],
    running: ['执行中', 'active', '◌'], started: ['已开始', 'active', '◌'],
    waiting: ['等待中', 'warn', '◷'], silent: ['保持静默', 'neutral', '—'],
    ignored: ['已忽略', 'neutral', '—'], completed: ['处理完成', 'good', '✓'],
    succeeded: ['执行完成', 'good', '✓'], success: ['执行成功', 'good', '✓'],
    prepared: ['已准备', 'active', '·'], queued: ['排队中', 'active', '◷'],
    sending: ['提交中', 'active', '◌'], local_accepted: ['本地已接受', 'warn', '↥'],
    message_recorded: ['消息已记录', 'warn', '≡'], server_confirmed: ['服务端已确认', 'good', '✓'],
    failed: ['失败', 'bad', '!'], error: ['错误', 'bad', '!'],
    cancelled: ['已取消', 'neutral', '×'], unknown: ['结果未知 · 需核对', 'warn', '?'],
    needs_review: ['需核对', 'warn', '?'], legacy_unknown: ['历史记录 · 无追踪', 'neutral', '—'],
    paused: ['已暂停', 'warn', 'Ⅱ'], stopped: ['已停止', 'neutral', '■'],
    idle: ['空闲', 'neutral', '·'], ready: ['就绪', 'good', '✓'],
  };
  const PHASES = { inbox: '收到消息', received: '收到消息', model: '模型处理', run: '模型处理',
    tool: '工具事件', outbox: '出站回复', delivery: '提交结果', decision: '处理决策', budget: '预算检查',
    ingress: '消息入站', participation: '参与决策', request: '模型请求' };
  const PURPOSES = { reply: '生成回复', decision: '回复决策', summary: '摘要整理', summarize: '摘要整理', participation: '参与决策', reflect: '反思整理', reflection: '反思整理', memory: '记忆整理' };
  const purposeLabel = (value) => PURPOSES[value] || text(value, '模型执行');
  const text = (value, fallback = '—') => typeof value === 'string' || typeof value === 'number' ? String(value) : fallback;
  const array = (value) => Array.isArray(value) ? value : [];
  const object = (value) => value !== null && typeof value === 'object' && !Array.isArray(value) ? value : {};
  const finite = (value) => typeof value === 'number' && Number.isFinite(value);
  const number = (value) => finite(value) ? new Intl.NumberFormat('zh-CN').format(value) : '—';
  const money = (value) => finite(value) ? `¥${value.toFixed(4).replace(/0+$/, '').replace(/\.$/, '')}` : '—';
  const timestamp = (value) => finite(value) && Number.isFinite(new Date(value).getTime()) ? value : null;
  const time = (value, compact = false) => timestamp(value) === null ? '时间未知' : new Intl.DateTimeFormat('zh-CN', compact
    ? { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false }
    : { month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false }).format(value);
  const fullTime = (value) => timestamp(value) === null ? '时间未知' : new Intl.DateTimeFormat('zh-CN', {
    year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false,
  }).format(value);
  const duration = (start, end) => timestamp(start) === null || timestamp(end) === null || end < start ? '未记录完整耗时' : elapsed(end - start);
  const elapsed = (ms) => !finite(ms) || ms < 0 ? '—' : ms < 1000 ? `${Math.round(ms)} ms` : ms < 60000 ? `${(ms / 1000).toFixed(1)} 秒` : `${Math.floor(ms / 60000)} 分 ${Math.round((ms % 60000) / 1000)} 秒`;
  const kindLabel = (kind) => ({ text: '文本', image: '图片', sticker: '表情', emoji: '表情', voice: '语音', video: '视频', file: '文件', group: '群聊', private: '私聊', direct: '私聊' })[kind] || text(kind, '消息');
  function el(tag, className, value) {
    const node = document.createElement(tag);
    if (className) node.className = className;
    if (value !== undefined) node.textContent = text(value, '');
    return node;
  }
  function statusBadge(value) {
    const [label, tone, icon] = STATUS[value] || [value ? `未识别状态：${text(value)}` : '状态未记录', 'neutral', '?'];
    const badge = el('span', 'status'); badge.dataset.tone = tone; badge.dataset.status = text(value, '');
    const symbol = el('span', 'status-icon', icon); symbol.setAttribute('aria-hidden', 'true');
    badge.append(symbol, el('span', '', label));
    return badge;
  }
  function timeNode(value, compact = false) {
    const node = el('time', '', time(value, compact));
    if (timestamp(value) !== null) { node.dateTime = new Date(value).toISOString(); node.title = fullTime(value); }
    return node;
  }
  function metadata(rows) {
    const list = el('dl', 'metadata');
    rows.forEach(([label, value, type]) => {
      if (value === undefined || value === null || value === '') return;
      const item = el('dd');
      if (type === 'id') item.append(el('code', '', value));
      else if (type === 'time') { const node = timeNode(value); node.textContent = fullTime(value); item.append(node); }
      else item.textContent = text(value);
      list.append(el('dt', '', label), item);
    });
    return list;
  }
  function bodyText(value, emptyLabel = '此消息没有可展示的文本。') {
    return el('p', `message-body${typeof value === 'string' && value.length ? '' : ' empty-text'}`, typeof value === 'string' && value.length ? value : emptyLabel);
  }
  function setPlaceholder(container, title, copy, loading = false) {
    const panel = el('div', 'list-placeholder');
    if (loading) panel.append(el('span', 'loading-mark'));
    panel.append(el('h3', '', title), el('p', '', copy)); container.replaceChildren(panel);
  }
  function cancel(channel) {
    const existing = state.requests.get(channel); if (existing) existing.abort();
    state.requests.delete(channel);
  }
  async function getJSON(channel, path) {
    cancel(channel);
    const controller = new AbortController(); state.requests.set(channel, controller);
    const timer = setTimeout(() => controller.abort('timeout'), 10000);
    try {
      const response = await fetch(path, { signal: controller.signal, cache: 'no-store', credentials: 'same-origin', headers: { Accept: 'application/json' } });
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const result = await response.json();
      if (state.requests.get(channel) !== controller) return null;
      if (!result || typeof result !== 'object' || Array.isArray(result) || result.error) throw new Error('invalid_response');
      state.failures.delete(channel); state.loaded.add(channel); state.lastSuccess = Date.now();
      renderConnection(); return result;
    } catch (error) {
      if (state.requests.get(channel) !== controller) return null;
      if (error.name === 'AbortError' && controller.signal.reason !== 'timeout') return null;
      state.failures.set(channel, error.message); renderConnection();
      throw error;
    } finally {
      clearTimeout(timer);
      if (state.requests.get(channel) === controller) state.requests.delete(channel);
    }
  }
  function renderConnection() {
    const failures = state.failures.size;
    const ready = state.loaded.size > 0;
    $('connection').dataset.state = failures ? ready ? 'partial' : 'offline' : ready ? 'online' : 'connecting';
    $('connection-text').textContent = failures ? ready ? '更新中断' : '连接失败' : ready ? '本地已连接' : '正在连接';
    $('connection').title = state.lastSuccess ? `最近成功读取 ${fullTime(state.lastSuccess)}；连接状态不代表机器人运行状态。` : '正在连接当前本地管理服务。';
    const banner = $('connection-banner'); banner.hidden = !failures;
    if (failures) banner.textContent = ready
      ? '部分数据暂时无法更新，当前显示的是最近读取的记录。正在自动重连；可点“刷新”重试。'
      : '无法读取本地管理服务。请确认管理服务已启动、地址正确；页面会自动重连。';
  }
  async function loadOverview() {
    try {
      const data = await getJSON('overview', '/api/overview'); if (!data) return;
      state.overview = data;
      const fingerprint = JSON.stringify({ ...data, now: null });
      if (fingerprint !== state.overviewFingerprint) { state.overviewFingerprint = fingerprint; renderOverview(); }
    } catch (_) {
      if (!state.overview) {
        $('trace-summary').textContent = '追踪状态暂不可用';
        $('source-content').replaceChildren(el('p', 'quiet-note', '服务状态暂不可用。请确认本地管理服务已启动；恢复连接后会自动更新。'));
      }
    }
  }
  async function loadServices() {
    try {
      const data = await getJSON('services', '/api/services');
      if (data) { state.services = data; renderServices(); }
    } catch (_) {
      $('service-status').textContent = '服务状态暂不可用';
      $('service-start').disabled = $('service-stop').disabled = $('budget-reset').disabled = true;
    }
  }
  function renderServices() {
    const data = state.services;
    if (!data) return;
    const busy = state.serviceSubmitting || !!data.operation;
    const bot = object(data.agent), bridge = object(data.bridge);
    const budget = object(object(state.overview).budget);
    const budgetPause = bot.running && ['budget_exhausted','budget_blocked'].includes(bot.state);
    const canReset = budget.enabled === true && budget.stopped === true && String(budget.reason).startsWith('daily_budget');
    $('budget-reset').disabled = !data.enabled || busy || !canReset;
    $('budget-reset').textContent = data.operation === 'reset-budget' ? '正在重置…' : '重置今日可用额度';
    $('service-start').disabled = !data.enabled || busy || bot.running || bot.ready && bridge.ready;
    $('service-stop').disabled = !data.enabled || busy || !(bot.running || bridge.reachable);
    $('service-start').textContent = data.operation === 'start' ? '正在开启…' : '开启服务';
    $('service-stop').textContent = data.operation === 'stop' ? '正在停止…' : '停止服务';
    const botLabel = bot.ready ? '运行中' : budgetPause ? bot.state === 'budget_exhausted' ? '已启动 · 预算暂停' : '已启动 · 预算配置异常' : bot.running ? '未就绪' : '已停止';
    $('service-status').textContent = !data.enabled ? '演示模式 · 服务控制已禁用' : data.operation === 'start' ? '正在开启机器人和微信桥接…' : data.operation === 'stop' ? '正在停止服务，等待当前任务清理…' : data.operation === 'reset-budget' ? '正在重置今日可用额度…' : `机器人：${botLabel}　·　微信桥接：${bridge.ready ? '运行中' : bridge.reachable ? '未就绪' : '已停止'}`;
    $('service-help').textContent = data.lastError ? data.lastError === 'budget_reset_failed' ? '额度未重置。请刷新预算状态；仅每日额度不足时可重置。' : '操作未完成。请查看 agent/data/startup 下的日志；可刷新状态后重试。' : canReset ? `可用余额 ${money(budget.remainingCny)}。点击重置后恢复 ${money(budget.configuredDailyLimitCny ?? budget.dailyLimitCny)} 可用额度，保留既有费用；今日累计花费可能超过原每日上限。运行中的机器人会自动恢复，旧消息不补发。` : '开启后恢复自动回复；停止后保留管理台和历史记录。';
  }
  async function serviceAction(action) {
    if (!state.services || state.serviceSubmitting || state.services.operation) return;
    state.serviceSubmitting = true;
    renderServices();
    try {
      const response = await fetch('/api/services/' + action, { method: 'POST', credentials: 'same-origin',
        headers: { 'Content-Type': 'application/json', 'X-Service-Token': state.services.token }, body: '{}', signal: AbortSignal.timeout(10000) });
      if (!response.ok) throw Error('service_action_failed');
      state.services.operation = action;
      $('announcement').textContent = action === 'reset-budget' ? '已请求重置今日可用额度，费用记录保留。' : action === 'start' ? '已请求开启服务。' : '已请求停止服务。';
    } catch (_) {
      $('service-help').textContent = '操作请求未完成，正在重新核对状态；请勿连续点击。';
    } finally {
      state.serviceSubmitting = false;
      renderServices();
      await loadServices();
    }
  }
  function renderOverview() {
    const data = state.overview; if (!data) return;
    renderServices();
    const runtime = object(data.runtime), trace = object(data.trace), budget = object(data.budget), checkpoint = object(data.checkpoint);
    $('trace-summary').textContent = trace.enabled === true ? '逐消息追踪已开启' : trace.enabled === false ? '逐消息追踪未开启' : '追踪状态未知';
    $('trace-summary').title = text(trace.note, '新旧消息的追踪完整性以各条记录为准。');
    const root = document.createDocumentFragment();
    const service = el('section', 'service-section'); service.append(el('h3', '', '机器人状态'));
    const serviceState = el('div', 'source-state'); serviceState.append(statusBadge(runtime.state));
    if (runtime.stale === true) serviceState.append(el('span', 'small', '状态记录已过期，不代表当前在线'));
    service.append(serviceState, metadata([['记录更新', runtime.updated, 'time'], ['检查点', checkpoint.cursor, 'id'], ['暂停状态', checkpoint.paused === true ? '暂停' : checkpoint.paused === false ? '未暂停' : '未知']]));
    const diagnostics = Array.isArray(runtime.diagnostics) ? runtime.diagnostics : [];
    diagnostics.filter((item) => typeof item === 'string').slice(0, 8).forEach((item) => service.append(el('p', 'service-note', item)));
    root.append(service);
    const budgetSection = el('section', 'service-section'); budgetSection.append(el('h3', '', '今日预算'));
    if (budget.enabled === true) {
      const line = el('p', 'budget-line'); line.append(el('strong', '', `${money(budget.spentCny)} 已用`), document.createTextNode(` / ${money(budget.dailyLimitCny)} 限额`));
      budgetSection.append(line, metadata([['日期', budget.day], ['每日配置额度', money(budget.configuredDailyLimitCny ?? budget.dailyLimitCny)], ['今日重置次数', number(budget.resetCount ?? 0)], ['预留金额', money(budget.heldCny)], ['可用余额', money(budget.remainingCny)], ['请求次数', number(budget.requestCount)], ['待核算请求', number(budget.uncertainRequests)], ['预算状态', budget.stopped ? '已暂停模型调用' : '未触发暂停'], ['原因', budget.reason], ['恢复时间', budget.resumesAt, 'time']]));
    } else budgetSection.append(el('p', 'quiet-note', budget.enabled === false ? '预算限制未开启。' : '未提供预算状态。'));
    root.append(budgetSection);
    const source = el('section', 'service-section'); source.append(el('h3', '', '追踪与来源'));
    source.append(metadata([['管理服务', location.origin], ['服务时间', data.now, 'time'], ['追踪开启', trace.since, 'time'], ['完整追踪', object(data.counts).traced], ['历史记录', object(data.counts).legacy]]));
    source.append(el('p', 'service-note', text(trace.note, '数据来自本地消息数据库及明确关联的追踪事件；不会按时间邻近猜测模型回复与消息的关系。')));
    root.append(source); $('source-content').replaceChildren(root);
  }
  async function loadMessages() {
    if (state.queryPending) return;
    const params = new URLSearchParams({ q: state.query, status: state.status, limit: String(PAGE_SIZE), offset: String(state.offset) });
    try {
      const data = await getJSON('messages', `/api/messages?${params}`); if (!data) return;
      state.messages = array(data.items).filter((item) => item && item.id !== undefined && item.id !== null);
      state.total = finite(data.total) ? data.total : state.messages.length;
      renderMessages();
    } catch (_) {
      if (!state.messages.length) setPlaceholder($('message-list'), '消息暂不可用', '请检查本地管理服务。连接恢复后会自动读取。');
    } finally { $('message-list').setAttribute('aria-busy', 'false'); }
  }
  function rowFor(message) {
    const button = el('button', 'message-row'); button.type = 'button'; button.dataset.id = String(message.id); button.dataset.testid = 'message-row';
    button.setAttribute('aria-pressed', String(String(message.id) === state.selectedId));
    const top = el('div', 'message-row-top');
    const conversation = text(message.conversationId, '会话未记录');
    const title = el('span', 'message-row-title', conversation); title.title = conversation;
    const received = timeNode(message.messageAt ?? message.receivedAt); received.className = 'message-row-time';
    top.append(title, received);
    const summary = el('p', 'message-row-text', typeof message.text === 'string' && message.text ? message.text : `[${kindLabel(message.kind)} · 无文本]`);
    const bottom = el('div', 'message-row-bottom'); bottom.append(statusBadge(message.status), el('span', 'message-row-kind', `${kindLabel(message.scope)} / ${kindLabel(message.kind)}`));
    button.append(top, summary, bottom);
    button.addEventListener('click', () => selectMessage(String(message.id)));
    button.dataset.fingerprint = JSON.stringify(message);
    return button;
  }
  function renderMessages() {
    const list = $('message-list');
    $('message-total').textContent = `${number(state.total)} 条`;
    $('page-label').textContent = state.total ? `${state.offset + 1}–${Math.min(state.offset + state.messages.length, state.total)} / ${number(state.total)}` : '每页 50 条';
    $('previous-page').disabled = state.offset === 0;
    $('next-page').disabled = state.offset + PAGE_SIZE >= state.total;
    if (!state.messages.length) {
      setPlaceholder(list, state.query || state.status || state.offset ? '没有匹配的消息' : '还没有消息记录', state.query || state.status ? '换个关键词，或选择“全部状态”再看看。' : state.offset ? '这一页暂无记录，请返回上一页。' : '当机器人收到消息后，真实记录会出现在这里。观察台不会主动发送消息。'); return;
    }
    const existing = new Map(Array.from(list.querySelectorAll('.message-row')).map((node) => [node.dataset.id, node]));
    const firstVisible = Array.from(existing.values()).find((node) => node.getBoundingClientRect().bottom > list.getBoundingClientRect().top);
    const anchor = firstVisible ? { id: firstVisible.dataset.id, top: firstVisible.getBoundingClientRect().top } : null;
    const oldScroll = list.scrollTop;
    const desired = state.messages.map((message) => {
      const old = existing.get(String(message.id));
      if (old && old.dataset.fingerprint === JSON.stringify(message)) return old;
      const node = rowFor(message);
      if (old && old === document.activeElement) { old.replaceChildren(...node.childNodes); old.dataset.fingerprint = node.dataset.fingerprint; return old; }
      return node;
    });
    const desiredSet = new Set(desired);
    for (const child of Array.from(list.children)) if (!desiredSet.has(child)) child.remove();
    desired.forEach((node, index) => { if (list.children[index] !== node) list.insertBefore(node, list.children[index] || null); });
    list.scrollTop = oldScroll;
    if (anchor) {
      const same = desired.find((node) => node.dataset.id === anchor.id);
      if (same) list.scrollTop += same.getBoundingClientRect().top - anchor.top;
    }
    updateSelection();
  }
  function updateSelection() {
    $('message-list').querySelectorAll('.message-row').forEach((node) => node.setAttribute('aria-pressed', String(node.dataset.id === state.selectedId)));
  }
  function selectMessage(id) {
    const changed = id !== state.selectedId;
    state.selectedId = id; $('messages-view').classList.add('detail-open'); updateSelection();
    if (changed) {
      cancel('detail'); state.detail = null; state.detailFingerprint = ''; $('message-detail').scrollTop = 0;
      const loader = el('div', 'detail-content'); loader.append(backButton(), el('p', 'quiet-note', '正在读取这条消息的处理记录…'));
      $('message-detail').replaceChildren(loader); $('message-detail').setAttribute('aria-busy', 'true');
    }
    if (window.matchMedia('(max-width: 760px)').matches) {
      const back = $('message-detail').querySelector('.mobile-back'); if (back) back.focus({ preventScroll: true });
    }
    loadDetail();
  }
  function backButton() {
    const button = el('button', 'mobile-back', '‹ 返回消息列表'); button.type = 'button'; button.dataset.testid = 'back-to-list'; button.dataset.focusKey = 'back';
    button.addEventListener('click', () => {
      $('messages-view').classList.remove('detail-open');
      const row = Array.from($('message-list').querySelectorAll('.message-row')).find((node) => node.dataset.id === state.selectedId); if (row) row.focus({ preventScroll: true });
    });
    return button;
  }
  async function loadDetail() {
    if (!state.selectedId) return;
    const selected = state.selectedId;
    try {
      const data = await getJSON('detail', `/api/messages/${encodeURIComponent(selected)}`);
      if (!data || selected !== state.selectedId) return;
      state.detail = data;
      const fingerprint = JSON.stringify(data);
      if (fingerprint !== state.detailFingerprint || $('detail-fetch-error')) {
        if (renderDetail(data) !== false) state.detailFingerprint = fingerprint;
      }
    } catch (_) {
      if (selected !== state.selectedId) return;
      if (!state.detail) {
        const root = el('div', 'detail-content'); root.append(backButton(), el('h2', '', '暂时无法读取这条消息'), el('p', 'quiet-note', '记录可能已被清理，或本地服务暂时不可用。页面将自动重试，你也可以选择其他消息。'));
        $('message-detail').replaceChildren(root);
      } else if (!$('detail-fetch-error')) {
        const note = el('p', 'detail-fetch-error', '详情更新中断，下方保留最近一次读取的记录。'); note.id = 'detail-fetch-error';
        $('message-detail').querySelector('.detail-content').prepend(note);
      }
    } finally { if (selected === state.selectedId) $('message-detail').setAttribute('aria-busy', 'false'); }
  }
  function makeStage(index, title, caption, testId) {
    const section = el('section', 'stage'); section.dataset.testid = testId;
    section.append(el('div', 'stage-marker', String(index).padStart(2, '0')));
    const content = el('div', 'stage-content'); const heading = el('div', 'stage-heading');
    heading.append(el('h3', '', title)); if (caption) heading.append(el('span', 'stage-caption', caption));
    content.append(heading); section.append(content); return { section, content };
  }
  function reasonNote(reason, isError = false) {
    const node = el('p', 'reason-note', `原因：${text(reason)}`); node.dataset.error = String(isError); return node;
  }
  function renderDetail(data) {
    const message = object(data.message); const runs = array(data.runs), outbox = array(data.outbox), events = array(data.timeline);
    const container = $('message-detail'); const oldScroll = container.scrollTop;
    const openDetails = new Map(Array.from(container.querySelectorAll('details[data-key]')).map((node) => [node.dataset.key, node.open]));
    const focusedKey = container.contains(document.activeElement) ? document.activeElement.dataset.focusKey : null;
    const textSelection = window.getSelection();
    if (container.childElementCount && textSelection && !textSelection.isCollapsed && container.contains(textSelection.anchorNode)) return false;
    const sections = Array.from(container.querySelectorAll('[data-testid]'));
    const visibleSection = sections.find((node) => node.getBoundingClientRect().bottom > container.getBoundingClientRect().top);
    const scrollAnchor = visibleSection ? {
      testid: visibleSection.dataset.testid, runId: visibleSection.dataset.runId, outboxId: visibleSection.dataset.outboxId,
      top: visibleSection.getBoundingClientRect().top,
    } : null;
    const root = el('div', 'detail-content'); root.append(backButton());
    const heading = el('div', 'detail-heading'); const titles = el('div', 'detail-title-group');
    titles.append(el('h2', '', text(message.conversationId, '消息详情')), el('p', 'detail-subtitle', `${kindLabel(message.scope)} · ${kindLabel(message.kind)} · ${fullTime(message.receivedAt)}`));
    const actions = el('div', 'detail-heading-actions'); actions.append(statusBadge(message.status));
    heading.append(titles, actions); root.append(heading);
    const hasTrace = data.traceAvailable === true;
    if (!hasTrace) {
      const warning = el('div', 'trace-warning', text(data.note, '这是一条缺少完整追踪的历史记录。无法可靠关联当时的模型执行与出站回复，不按时间相近推测。')); warning.dataset.testid = 'legacy-warning'; root.append(warning);
    } else if (data.note) root.append(el('p', 'quiet-note', data.note));
    const journey = el('ol', 'journey-summary'); journey.setAttribute('aria-label', '消息处理阶段');
    [['收到消息', message.receivedAt ? time(message.receivedAt, true) : '时间未记录'], ['模型处理', hasTrace ? `${runs.length} 次执行` : '无可靠追踪'], ['出站回复', hasTrace ? `${outbox.length} 条记录` : '无可靠追踪']].forEach(([label, hint], index) => {
      const step = el('li', 'journey-step'); const labels = el('div'); labels.append(el('strong', '', label), el('small', '', hint)); step.append(el('span', 'journey-number', index + 1), labels); journey.append(step);
    }); root.append(journey);
    const inbound = makeStage(1, '收到消息', '原始入站', 'inbound-stage'); const incoming = el('div', 'content-panel inbound-panel');
    incoming.append(bodyText(message.text), metadata([['消息 ID', message.messageId, 'id'], ['记录 ID', message.id, 'id'], ['会话 ID', message.conversationId, 'id'], ['发送者', message.senderId, 'id'], ['消息时间', message.messageAt, 'time'], ['接收时间', message.receivedAt, 'time'], ['序列', message.sequence]]));
    if (message.reason) incoming.append(reasonNote(message.reason, message.status === 'failed'));
    inbound.content.append(incoming); root.append(inbound.section);
    const model = makeStage(2, '模型处理', '仅最终回复与工具摘要', 'model-stage');
    if (!hasTrace) model.content.append(el('p', 'stage-empty', '没有可验证的模型追踪，不展示推测的关联结果。'));
    else if (!runs.length) {
      const hint = message.status === 'silent' ? '本条消息保持静默，没有记录到模型执行。' : message.status === 'ignored' ? '这条消息已忽略，没有记录到模型执行。' : message.status === 'waiting' ? '消息正在等待，尚无模型执行记录。' : '暂未记录模型执行。若正在处理中，后续事件将自动更新。';
      model.content.append(el('p', 'stage-empty', hint));
    } else runs.forEach((run) => model.content.append(renderRun(object(run))));
    root.append(model.section);
    const outbound = makeStage(3, '出站回复', '逐条核对提交结果', 'outbound-stage');
    if (!hasTrace) outbound.content.append(el('p', 'stage-empty', '没有可验证的出站追踪，无法确定是否回复。'));
    else if (!outbox.length) outbound.content.append(el('p', 'stage-empty', message.status === 'silent' ? '保持静默：未产生出站回复。' : '尚无出站回复记录。模型有最终输出也不代表已提交给微信。'));
    else outbox.forEach((item, index) => outbound.content.append(renderOutbox(object(item), index)));
    root.append(outbound.section);
    if (hasTrace) root.append(renderTimeline(events));
    container.replaceChildren(root);
    container.querySelectorAll('details[data-key]').forEach((node) => { if (openDetails.has(node.dataset.key)) node.open = openDetails.get(node.dataset.key); });
    container.scrollTop = oldScroll;
    if (scrollAnchor && oldScroll > 0) {
      const anchor = Array.from(container.querySelectorAll('[data-testid]')).find((node) => node.dataset.testid === scrollAnchor.testid && node.dataset.runId === scrollAnchor.runId && node.dataset.outboxId === scrollAnchor.outboxId);
      if (anchor) container.scrollTop += anchor.getBoundingClientRect().top - scrollAnchor.top;
    }
    if (focusedKey) { const target = Array.from(container.querySelectorAll('[data-focus-key]')).find((node) => node.dataset.focusKey === focusedKey); if (target) target.focus({ preventScroll: true }); }
  }
  function renderRun(run) {
    const panel = el('article', 'content-panel'); panel.dataset.testid = 'model-run'; panel.dataset.runId = text(run.id, '');
    const heading = el('div', 'panel-heading'); const label = el('div'); label.append(el('div', 'panel-heading-label', purposeLabel(run.purpose)), el('div', 'model-label', `${text(run.provider, '提供方未记录')} / ${text(run.model, '模型未记录')}`));
    heading.append(label, statusBadge(run.state)); panel.append(heading);
    const finals = array(run.finalTexts).map((item) => typeof item === 'string' ? item : text(object(item).text, '')).filter(Boolean);
    if (finals.length) {
      panel.append(el('p', 'run-reply-label', '模型最终回复'));
      finals.forEach((reply) => { const block = el('div', 'reply-block'); block.dataset.testid = 'final-reply'; block.append(bodyText(reply)); panel.append(block); });
    } else panel.append(el('p', 'quiet-note', run.state === 'silent' ? '模型选择保持静默，没有最终回复。' : '尚未记录最终回复；中间思考不展示。'));
    panel.append(metadata([['开始', run.startedAt, 'time'], ['结束', run.endedAt, 'time'], ['耗时', duration(run.startedAt, run.endedAt)], ['运行 ID', run.id, 'id'], ['执行 ID', run.executionId, 'id'], ['关联消息', array(run.sourceIds).map((value) => text(value, '')).filter(Boolean).join(', '), 'id']]));
    const tools = array(run.tools);
    if (tools.length) {
      const details = el('details', 'subsection'); details.dataset.key = `tools-${text(run.id)}`;
      const summary = el('summary', '', `工具事件摘要 (${tools.length})`); summary.dataset.focusKey = `tools-${text(run.id)}`; details.append(summary);
      const list = el('ul', 'tool-list'); tools.forEach((item) => {
        const tool = object(item); const row = el('li', 'tool-row'); row.dataset.testid = 'tool-event'; const content = el('div');
        content.append(el('div', 'tool-name', text(tool.name, '工具事件')));
        const facts = [timestamp(tool.startedAt) !== null ? time(tool.startedAt, true) : '', timestamp(tool.endedAt) !== null ? duration(tool.startedAt, tool.endedAt) : '', typeof tool.code === 'string' ? `代码：${tool.code}` : ''].filter(Boolean);
        if (facts.length) content.append(el('p', 'tool-summary', facts.join(' · ')));
        if (tool.callId) content.append(el('p', 'tool-summary', `调用 ID：${text(tool.callId)}`));
        row.append(content, statusBadge(tool.state)); list.append(row);
      }); details.append(list); panel.append(details);
    }
    const usage = array(run.usage);
    if (usage.length) {
      const totals = new Map();
      const fields = [['inputTokens', '输入 token'], ['outputTokens', '输出 token'], ['cacheReadTokens', '缓存读取'], ['cacheWriteTokens', '缓存写入']];
      usage.forEach((item) => { const record = object(item); fields.forEach(([key, label]) => { if (finite(record[key])) totals.set(label, (totals.get(label) || 0) + record[key]); }); });
      const line = el('div', 'usage-row'); line.dataset.testid = 'usage';
      if (totals.size) totals.forEach((value, label) => { const node = el('span'); node.append(document.createTextNode(`${label} `), el('strong', '', label === '费用' ? money(value) : number(value))); line.append(node); });
      else line.append(el('span', '', '已记录用量事件，暂无可展示的数值。'));
      panel.append(line);
      const detail = el('details', 'subsection'); detail.dataset.key = `usage-${text(run.id)}`;
      const summary = el('summary', '', `请求用量记录 (${usage.length})`); summary.dataset.focusKey = `usage-${text(run.id)}`; detail.append(summary);
      usage.forEach((item) => {
        const record = object(item);
        detail.append(metadata([['请求 ID', record.requestId, 'id'], ['记录时间', record.at, 'time'], ...fields.map(([key, label]) => [label, finite(record[key]) ? number(record[key]) : '未记录'])]));
      });
      detail.append(el('p', 'service-note', '上方合计仅累加已记录数值；缺失用量不视为 0。'));
      panel.append(detail);
    }
    return panel;
  }
  function renderOutbox(item, index) {
    const panel = el('article', 'content-panel'); panel.dataset.testid = 'outbox-item'; panel.dataset.outboxId = text(item.id, '');
    const heading = el('div', 'panel-heading'); heading.append(el('span', 'panel-heading-label', `回复 ${index + 1} · ${kindLabel(item.kind)}`), statusBadge(item.state)); panel.append(heading, bodyText(item.text, '非文本回复或未记录正文。'));
    panel.append(metadata([['出站 ID', item.id, 'id'], ['运行 ID', item.runId, 'id'], ['回复 ID', item.replyId, 'id'], ['分段', item.part], ['创建时间', item.createdAt, 'time'], ['状态更新', item.updatedAt, 'time'], ['提交记录', typeof item.submitted === 'boolean' ? item.submitted ? '已提交（不代表送达）' : '未提交' : timestamp(item.submitted) !== null ? fullTime(item.submitted) : '未记录']]));
    if (item.error) panel.append(reasonNote(item.error, true));
    const notes = {
      unknown: '结果未知，需要核对；请勿据此认定送达，也不要盲目重发。',
      needs_review: '需要人工核对现有提交结果，观察台不会自动重试。',
      local_accepted: '本地发送接口已接受；尚不能证明服务端接受或对方收到。',
      message_recorded: '消息已写入记录；不能证明对方实际收到。',
      server_confirmed: '服务端已确认该提交，但不证明对方实际收到或已读。',
      completed: '此处的完成仅指本地处理状态，不代表对方实际收到。',
    };
    panel.append(el('p', 'delivery-note', notes[item.state] || '提交状态来自本地追踪，不作为对方已收件或已读的证明。'));
    return panel;
  }
  function renderTimeline(events) {
    const details = el('details', 'event-section'); details.dataset.key = 'events'; details.dataset.testid = 'event-timeline';
    const summary = el('summary', '', `事件时间线 · ${events.length} 条`); summary.dataset.focusKey = 'events'; details.append(summary);
    if (!events.length) { details.append(el('p', 'quiet-note', '暂无阶段事件。')); return details; }
    const list = el('ol', 'event-list');
    events.forEach((item) => {
      const event = object(item); const row = el('li', 'event-row'); row.append(timeNode(event.at, true));
      const content = el('div'); const description = el('div', 'event-description'); description.append(el('span', '', PHASES[event.phase] || text(event.phase, '事件')), statusBadge(event.state)); content.append(description);
      const ids = [['事件', event.id], ['运行', event.runId], ['出站', event.outboxId]].filter(([, value]) => value !== undefined && value !== null).map(([label, value]) => `${label} ${text(value)}`);
      if (ids.length) content.append(el('p', 'event-meta', ids.join(' · ')));
      const safe = object(event.details);
      const safeLabels = { reason: '原因', purpose: '用途', part: '分段', kind: '类型', submitted: '提交记录', requestId: '请求 ID', name: '工具', callId: '调用 ID', inputTokens: '输入 token', outputTokens: '输出 token', cacheReadTokens: '缓存读取', cacheWriteTokens: '缓存写入', code: '代码' };
      Object.entries(safeLabels).forEach(([key, label]) => {
        if (typeof safe[key] === 'string' || finite(safe[key]) || typeof safe[key] === 'boolean') content.append(el('p', 'event-meta', `${label}：${typeof safe[key] === 'boolean' ? safe[key] ? '是' : '否' : key === 'purpose' ? purposeLabel(safe[key]) : key === 'kind' ? kindLabel(safe[key]) : safe[key]}`));
      });
      row.append(content); list.append(row);
    }); details.append(list); return details;
  }
  function resetMessageFilter() {
    clearTimeout(state.queryTimer); state.queryPending = false; cancel('messages'); state.query = $('message-search').value.trim(); state.status = $('status-filter').value; state.offset = 0;
    state.messages = []; $('message-list').scrollTop = 0; $('message-list').setAttribute('aria-busy', 'true');
    setPlaceholder($('message-list'), '正在查找消息', '保留当前详情，列表正在更新。', true);
    loadMessages();
  }
  function safeImageURL(value) {
    if (typeof value !== 'string') return null;
    try { const url = new URL(value, location.origin); return url.origin === location.origin && /^\/api\/stickers\/[^/]+\/image$/.test(url.pathname) && !url.username && !url.password ? url.href : null; } catch (_) { return null; }
  }
  async function loadStickers() {
    const params = new URLSearchParams({ q: state.stickerQuery, limit: String(PAGE_SIZE), offset: String(state.stickerOffset) });
    try {
      const data = await getJSON('stickers', `/api/stickers?${params}`); if (!data) return;
      state.stickers = array(data.items).filter((item) => item && item.id !== undefined); state.stickerTotal = finite(data.total) ? data.total : state.stickers.length;
      const fingerprint = JSON.stringify(data);
      if (fingerprint !== state.stickerFingerprint) { state.stickerFingerprint = fingerprint; renderStickers(data); }
    } catch (_) {
      $('sticker-note').textContent = '表情目录读取失败。请检查本地服务，或点击“刷新”重试。';
      if (!state.stickers.length) stickerEmpty('表情库暂不可用', '没有加载任何远程图片。');
    } finally { $('sticker-grid').setAttribute('aria-busy', 'false'); }
  }
  function stickerEmpty(title, copy) {
    const empty = el('div', 'grid-empty'); empty.append(el('h3', '', title), el('p', '', copy)); $('sticker-grid').replaceChildren(empty);
  }
  let observer = null;
  function renderStickers(data) {
    state.thumbnailGeneration++; state.thumbnailQueue = []; if (observer) observer.disconnect();
    $('sticker-note').textContent = text(data.note, data.enabled === false ? '本地表情库未启用。' : '来源：本地表情目录。封面按需加载，动图仅在预览时播放。') + (data.truncated ? ' 目录结果已截断，可缩小搜索范围。' : '');
    $('sticker-page-label').textContent = state.stickerTotal ? `${state.stickerOffset + 1}–${Math.min(state.stickerOffset + state.stickers.length, state.stickerTotal)} / ${number(state.stickerTotal)} 个` : '0 个表情';
    $('sticker-previous').disabled = state.stickerOffset === 0; $('sticker-next').disabled = state.stickerOffset + PAGE_SIZE >= state.stickerTotal;
    if (!state.stickers.length) { stickerEmpty(data.enabled === false ? '表情库未启用' : state.stickerQuery ? '没有匹配的表情' : '本地表情库还是空的', state.stickerQuery ? '试试其他描述词。' : '目录中有可用表情后会显示在这里。'); return; }
    const fragment = document.createDocumentFragment();
    const targets = [];
    state.stickers.forEach((item) => {
      const card = el('button', 'sticker-card'); card.type = 'button'; card.dataset.testid = 'sticker-card'; card.dataset.id = String(item.id);
      card.setAttribute('aria-label', `预览表情：${text(item.caption, '未命名表情')}`);
      const cover = el('div', 'sticker-cover', '封面待加载'); cover.dataset.state = 'pending';
      const mime = text(item.mime, ''); const format = mime.split('/')[1]?.toUpperCase() || '图片';
      card.append(cover, el('p', 'sticker-caption', text(item.caption, '未命名表情')), el('p', 'sticker-size', `${format} · ${fileSize(item.bytes)}`));
      card.addEventListener('click', () => previewSticker(item)); fragment.append(card);
      targets.push({ cover, item, generation: state.thumbnailGeneration });
    });
    const scroll = $('stickers-view').scrollTop; $('sticker-grid').replaceChildren(fragment); $('stickers-view').scrollTop = scroll;
    if ('IntersectionObserver' in window) {
      const map = new Map(targets.map((target) => [target.cover, target]));
      observer = new IntersectionObserver((entries) => { entries.forEach((entry) => { if (entry.isIntersecting) { observer.unobserve(entry.target); state.thumbnailQueue.push(map.get(entry.target)); } }); processThumbnails(); }, { root: $('stickers-view'), rootMargin: '80px' });
      targets.forEach((target) => observer.observe(target.cover));
    } else { state.thumbnailQueue.push(...targets); processThumbnails(); }
  }
  function fileSize(bytes) { return !finite(bytes) ? '大小未知' : bytes < 1024 ? `${bytes} B` : bytes < 1048576 ? `${(bytes / 1024).toFixed(1)} KB` : `${(bytes / 1048576).toFixed(1)} MB`; }
  function processThumbnails() {
    if (state.view !== 'stickers' || document.hidden) return;
    while (state.thumbnailJobs < 2 && state.thumbnailQueue.length) {
      const job = state.thumbnailQueue.shift(); if (!job || job.generation !== state.thumbnailGeneration || !job.cover.isConnected) continue;
      state.thumbnailJobs++;
      loadThumbnail(job).finally(() => { state.thumbnailJobs--; processThumbnails(); });
    }
  }
  async function loadThumbnail({ cover, item, generation }) {
    const url = safeImageURL(item.imageUrl);
    if (!url) { cover.textContent = '图片地址不可用'; cover.dataset.state = 'error'; return; }
    // No animated <img> enters the grid. Decode at most two visible images,
    // copy a frame to canvas, then release their sources immediately.
    await new Promise((resolve) => {
      const image = new Image(); image.decoding = 'async'; let timer;
      const finish = () => { clearTimeout(timer); image.onload = null; image.onerror = null; image.removeAttribute('src'); resolve(); };
      image.onload = () => {
        if (generation !== state.thumbnailGeneration || !cover.isConnected) { finish(); return; }
        try {
          const canvas = document.createElement('canvas'); const ratio = Math.min(1, 360 / Math.max(image.naturalWidth, image.naturalHeight));
          canvas.width = Math.max(1, Math.round(image.naturalWidth * ratio)); canvas.height = Math.max(1, Math.round(image.naturalHeight * ratio));
          canvas.setAttribute('aria-hidden', 'true'); const context = canvas.getContext('2d');
          if (!context) throw new Error('no_canvas');
          context.drawImage(image, 0, 0, canvas.width, canvas.height); cover.replaceChildren(canvas);
          if (text(item.mime, '').includes('gif')) cover.append(el('span', 'sticker-format', 'GIF · 点击播放'));
          cover.dataset.state = 'loaded';
        } catch (_) { cover.textContent = '封面不可用 · 点击预览'; cover.dataset.state = 'error'; }
        finish();
      };
      image.onerror = () => { if (cover.isConnected) { cover.textContent = '图片加载失败'; cover.dataset.state = 'error'; } finish(); };
      timer = setTimeout(() => { if (cover.isConnected) { cover.textContent = '封面加载超时'; cover.dataset.state = 'error'; } finish(); }, 10000);
      image.src = url;
    });
  }
  function previewSticker(item) {
    $('sticker-preview-title').textContent = text(item.caption, '表情预览'); const imageRoot = $('sticker-preview-image'); imageRoot.replaceChildren();
    const url = safeImageURL(item.imageUrl);
    const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    const isAnimated = /gif|webp|png/i.test(text(item.mime, ''));
    const show = () => {
      const image = new Image(); image.alt = text(item.caption, '表情预览'); image.dataset.testid = 'sticker-preview-img';
      image.addEventListener('error', () => imageRoot.replaceChildren(el('p', '', '图片暂时无法加载。'))); image.src = url; imageRoot.replaceChildren(image);
    };
    if (!url) imageRoot.append(el('p', '', '图片地址无效，已阻止加载。'));
    else if (reduced && isAnimated) {
      const play = el('button', 'button', '播放图片（可能含动画）'); play.type = 'button'; play.addEventListener('click', show); imageRoot.append(play);
    } else show();
    const meta = $('sticker-preview-meta'); meta.replaceChildren(el('p', '', `${text(item.mime, '格式未知')} · ${fileSize(item.bytes)}`), el('p', 'muted', `来源：${text(item.source, '本地表情目录（原始路径不公开）')}`), el('p', 'small muted', `表情 ID：${text(item.id)}`));
    $('sticker-dialog').showModal();
  }
  function changeView(view) {
    state.view = view; const messages = view === 'messages';
    $('messages-view').hidden = !messages; $('stickers-view').hidden = messages;
    $('page-title').textContent = messages ? '消息观察台' : '本地表情库';
    document.querySelector('.skip-link').href = messages ? '#message-search' : '#sticker-search';
    document.querySelector('.skip-link').textContent = messages ? '跳到消息搜索' : '跳到表情搜索';
    ['messages', 'stickers'].forEach((key) => { const nav = $(`nav-${key}`); nav.classList.toggle('active', key === view); if (key === view) nav.setAttribute('aria-current', 'page'); else nav.removeAttribute('aria-current'); });
    if (messages) { state.failures.delete('stickers'); loadMessages(); if (state.selectedId) loadDetail(); }
    else { state.failures.delete('detail'); cancel('detail'); loadStickers(); processThumbnails(); }
    renderConnection(); schedulePoll();
  }
  function schedulePoll() { clearTimeout(state.timer); state.timer = setTimeout(poll, document.hidden ? 30000 : 2000); }
  async function poll() {
    if (state.polling) { schedulePoll(); return; }
    state.polling = true;
    try {
      const jobs = [loadOverview(), loadServices()];
      if (state.view === 'messages') { jobs.push(loadMessages()); if (state.selectedId) jobs.push(loadDetail()); }
      else if (state.failures.has('stickers')) jobs.push(loadStickers());
      await Promise.allSettled(jobs);
    } finally { state.polling = false; schedulePoll(); }
  }
  function refresh() {
    if (state.view === 'stickers') loadStickers();
    poll(); $('announcement').textContent = '正在刷新本地记录。';
  }
  $('nav-messages').addEventListener('click', () => changeView('messages'));
  $('nav-stickers').addEventListener('click', () => changeView('stickers'));
  $('refresh-button').addEventListener('click', refresh);
  $('message-search').addEventListener('input', () => { clearTimeout(state.queryTimer); state.queryPending = true; cancel('messages'); state.queryTimer = setTimeout(resetMessageFilter, 300); });
  $('status-filter').addEventListener('change', resetMessageFilter);
  $('message-search').addEventListener('keydown', (event) => { if (event.key === 'Enter') resetMessageFilter(); });
  $('previous-page').addEventListener('click', () => { state.offset = Math.max(0, state.offset - PAGE_SIZE); $('message-list').scrollTop = 0; loadMessages(); });
  $('next-page').addEventListener('click', () => { state.offset += PAGE_SIZE; $('message-list').scrollTop = 0; loadMessages(); });
  $('sticker-search').addEventListener('input', () => {
    clearTimeout(state.stickerTimer); cancel('stickers');
    state.stickerTimer = setTimeout(() => { state.stickerQuery = $('sticker-search').value.trim(); state.stickerOffset = 0; state.stickerFingerprint = ''; state.stickers = []; $('stickers-view').scrollTop = 0; $('sticker-grid').setAttribute('aria-busy', 'true'); loadStickers(); }, 300);
  });
  $('sticker-previous').addEventListener('click', () => { state.stickerOffset = Math.max(0, state.stickerOffset - PAGE_SIZE); $('stickers-view').scrollTop = 0; loadStickers(); });
  $('sticker-next').addEventListener('click', () => { state.stickerOffset += PAGE_SIZE; $('stickers-view').scrollTop = 0; loadStickers(); });
  const openSource = () => { $('source-dialog').showModal(); if (!state.overview) loadOverview(); };
  $('source-toggle').addEventListener('click', openSource); $('privacy-button').addEventListener('click', openSource);
  $('source-close').addEventListener('click', () => $('source-dialog').close());
  $('service-start').addEventListener('click', () => serviceAction('start'));
  $('service-stop').addEventListener('click', () => serviceAction('stop'));
  $('budget-reset').addEventListener('click', () => serviceAction('reset-budget'));
  $('sticker-close').addEventListener('click', () => $('sticker-dialog').close());
  $('sticker-dialog').addEventListener('close', () => $('sticker-preview-image').replaceChildren());
  for (const dialog of [$('source-dialog'), $('sticker-dialog')]) dialog.addEventListener('click', (event) => { if (event.target === dialog) { const box = dialog.getBoundingClientRect(); if (event.clientX < box.left || event.clientX > box.right || event.clientY < box.top || event.clientY > box.bottom) dialog.close(); } });
  document.addEventListener('visibilitychange', () => { clearTimeout(state.timer); if (!document.hidden) { poll(); processThumbnails(); } else schedulePoll(); });
  window.addEventListener('online', refresh);
  window.addEventListener('offline', () => { state.failures.set('network', 'offline'); renderConnection(); });
  window.addEventListener('online', () => { state.failures.delete('network'); renderConnection(); });
  window.addEventListener('pagehide', () => { clearTimeout(state.timer); for (const key of state.requests.keys()) cancel(key); });
  poll();
})();
