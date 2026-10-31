import { createServer, type IncomingMessage, type ServerResponse } from 'node:http';
import { readFileSync, realpathSync, lstatSync } from 'node:fs';
import { resolve, relative, isAbsolute } from 'node:path';
import type { Config } from '../config.js';
import { StickerLibrary } from '../media/stickers.js';
import { AdminReadModel, safeText } from './read-model.js';
import { randomBytes, timingSafeEqual } from 'node:crypto';
import type { ServiceControl, ServiceAction } from './service-control.js';

export function createAdminServer(config: Config, options: { staticRoot: string; clock?: () => number; services?: ServiceControl } ) {
  const model = new AdminReadModel(config, options.clock);
  const serviceToken = randomBytes(32).toString('hex');
  const json = (res: ServerResponse, status: number, value: unknown) => {
    res.writeHead(status, { 'Content-Type':'application/json; charset=utf-8' }); res.end(JSON.stringify(value));
  };
  const server = createServer(async (req, res) => {
    res.setHeader('Cache-Control','no-store'); res.setHeader('X-Content-Type-Options','nosniff');
    res.setHeader('Referrer-Policy','no-referrer'); res.setHeader('Cross-Origin-Resource-Policy','same-origin');
    res.setHeader('X-Frame-Options','DENY');
    res.setHeader('Content-Security-Policy',"default-src 'none'; script-src 'self'; style-src 'self'; img-src 'self' data: blob:; connect-src 'self'; base-uri 'none'; frame-ancestors 'none'; form-action 'none'");
    try {
      const port = (server.address() as {port:number}|null)?.port;
      const hosts = new Set([`127.0.0.1:${port}`,`localhost:${port}`]);
      if (!hosts.has(req.headers.host ?? '')) return json(res,403,{error:'host_denied'});
      const origin = 'http://' + req.headers.host;
      if (req.headers.origin && req.headers.origin !== origin || req.headers['sec-fetch-site'] && !['same-origin','none'].includes(String(req.headers['sec-fetch-site'])))
        return json(res,403,{error:'origin_denied'});
      if (req.headers.referer) { try { if(new URL(req.headers.referer).origin!==origin) return json(res,403,{error:'origin_denied'}); } catch { return json(res,403,{error:'origin_denied'}); } }
      const raw = req.url ?? '/';
      if (raw.length>2048 || !raw.startsWith('/') || raw.startsWith('//')) return json(res,400,{error:'invalid_request'});
      const decoded = decodeURIComponent(raw.split('?')[0]!);
      if (decoded.includes('\\') || decoded.split('/').some(s=>s==='..'||s==='.') || /[\x00-\x1f]/.test(decoded)) return json(res,400,{error:'path_denied'});
      const url = new URL(raw,origin), path = url.pathname;
      if (path === '/api/services' && req.method === 'GET') {
        return json(res, 200, options.services ? { ...await options.services.status(), token: serviceToken } : { enabled: false });
      }
      const serviceAction = /^\/api\/services\/(start|stop|reset-budget)$/.exec(path);
      if (serviceAction && req.method === 'POST') {
        if (!options.services) return json(res, 403, { error: 'service_control_disabled' });
        const supplied = req.headers['x-service-token'];
        if (req.headers.origin !== origin || typeof supplied !== 'string' || !/^[a-f0-9]{64}$/.test(supplied) ||
            !timingSafeEqual(Buffer.from(supplied), Buffer.from(serviceToken))) return json(res, 403, { error: 'service_control_denied' });
        if (req.headers['content-type'] !== 'application/json') return json(res, 415, { error: 'json_required' });
        if (Number(req.headers['content-length'] ?? 0) > 256) { req.resume(); return json(res, 413, { error: 'body_too_large' }); }
        let body = '';
        for await (const chunk of req) { body += chunk; if (Buffer.byteLength(body) > 256) return json(res, 413, { error: 'body_too_large' }); }
        let value;
        try { value = JSON.parse(body); } catch { return json(res, 400, { error: 'invalid_action_body' }); }
        if (!value || Array.isArray(value) || typeof value !== 'object' || Object.keys(value).length) return json(res, 400, { error: 'invalid_action_body' });
        const action = serviceAction[1] as ServiceAction;
        return options.services.action(action) ? json(res, 202, { accepted: true, operation: action }) : json(res, 409, { error: 'service_operation_busy' });
      }
      if (req.method !== 'GET' && req.method !== 'HEAD') { res.setHeader('Allow','GET, HEAD'); return json(res,405,{error:'read_only'}); }
      const number = (name:string, fallback:number, max:number) => {
        const value = url.searchParams.get(name); if(value===null)return fallback;
        if(!/^\d+$/.test(value)||!Number.isSafeInteger(Number(value))||Number(value)>max||name==='limit'&&Number(value)<1)throw Error('invalid_query');
        return Number(value);
      };
      const q = url.searchParams.get('q')??''; if(q.length>200)throw Error('invalid_query');
      if(path==='/api/overview')return json(res,200,model.overview());
      if(path==='/api/messages')return json(res,200,model.messages({q,status:url.searchParams.get('status')??'',limit:number('limit',50,100),offset:number('offset',0,1000000),after:number('after',0,Number.MAX_SAFE_INTEGER)}));
      const message = /^\/api\/messages\/([a-f0-9]{64})$/.exec(path);
      if(message) { const detail=model.detail(message[1]!); return json(res,detail?200:404,detail??{error:'not_found'}); }
      if(path==='/api/stickers') {
        const offset=number('offset',0,1000000),limit=number('limit',50,100);
        if(!config.stickers.enabled)return json(res,200,{enabled:false,items:[],total:0,offset,limit,truncated:false,note:'表情库未启用。'});
        const result=new StickerLibrary(config).list(offset,limit,q);
        return json(res,200,{...result,enabled:true,items:result.items.map(e=>({id:e.emoji_id,caption:safeText(e.caption,240),mime:e.mime,bytes:e.bytes,imageUrl:'/api/stickers/'+e.emoji_id+'/image'}))});
      }
      const sticker = /^\/api\/stickers\/([a-f0-9]{64})\/image$/.exec(path);
      if(sticker) {
        if(!config.stickers.enabled)return json(res,404,{error:'not_found'});
        // Fresh bounded instance: no lifetime image cache or stale ID/path trust.
        const library=new StickerLibrary(config),items=library.list(0,config.stickers.maxFiles).items;
        if(!items.some(e=>e.emoji_id===sticker[1]))return json(res,404,{error:'not_found'});
        const image=library.read(sticker[1]!);
        res.writeHead(200,{'Content-Type':image.entry.mime,'Content-Length':image.bytes.length});res.end(req.method==='HEAD'?undefined:image.bytes);return;
      }
      const assets:Record<string,[string,string]>={'/':['index.html','text/html; charset=utf-8'],'/index.html':['index.html','text/html; charset=utf-8'],'/app.js':['app.js','text/javascript; charset=utf-8'],'/styles.css':['styles.css','text/css; charset=utf-8']};
      const asset=assets[path]; if(!asset)return json(res,404,{error:'not_found'});
      const root=realpathSync(options.staticRoot),file=resolve(root,asset[0]),stat=lstatSync(file),canonical=realpathSync(file),rel=relative(root,canonical);
      if(stat.isSymbolicLink()||stat.nlink!==1||!stat.isFile()||rel.startsWith('..')||isAbsolute(rel)||stat.size>2*1024*1024)return json(res,404,{error:'not_found'});
      res.writeHead(200,{'Content-Type':asset[1]});res.end(req.method==='HEAD'?undefined:readFileSync(canonical));
    } catch(error) {
      const message=error instanceof Error?error.message:'';
      json(res,message==='invalid_query'||error instanceof URIError?400:503,{error:message==='invalid_query'?'invalid_query':error instanceof URIError?'invalid_path':'temporarily_unavailable'});
    }
  });
  server.requestTimeout=10000;server.headersTimeout=10000;server.maxHeadersCount=40;
  server.on('close',()=>model.close());
  return {server,model};
}
