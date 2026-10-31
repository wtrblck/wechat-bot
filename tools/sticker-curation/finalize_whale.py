from pathlib import Path
import json, html, base64, sys, hashlib
from collections import Counter
from PIL import Image, ImageDraw, ImageFont
root=Path(sys.argv[1]).resolve()
source=root/'source-kiriyuki'
evidence=root/'source-github-loping151'
evidence.mkdir(exist_ok=True)
for name in ['upstream-meta.json','LICENSE-ASSETS.txt','README-upstream.txt']:
    if (source/name).exists(): (source/name).rename(evidence/name)
m=json.loads((root/'manifest.json').read_text(encoding='utf-8'))
review='已人工查看首/中/末三帧联系图；无明显广告、严重水印、色情、仇恨或恶意攻击。全部帧均完成解码校验，但人工审图为抽帧，不等同逐帧内容审核。'
for i in m['items']:
    i['visual_review']=review
    if i['number'] in (5,22,27): i['usage_note']='轻度嫌弃/调侃，仅熟人友善语境；不用于辱骂。'
    i['category']=('吃饭零食' if i['number'] in (11,15,29,30,36,37,40,44) else '摸鱼困倦' if i['number'] in (2,9,14,20,24,42,47) else '困惑思考' if i['number'] in (3,4,7,21,28,38,39) else '嘴硬互怼' if i['number'] in (5,10,16,19,22,27,33,50) else '委屈安慰亲近' if i['number'] in (13,18,26,34,35,43,45,46,49) else '开心招呼认可')
m['review']=review
m['category_counts']=dict(Counter(i['category'] for i in m['items']))
m['compatibility']={'code_file':'agent/src/media/stickers.ts','formats':['png','jpg','jpeg','gif','webp'],'config_default_max_file_mib':10,'actual_runtime_config_read':False,'note':'只读加载逻辑和配置schema，未读取实际配置、聊天或凭据。50张均为原始GIF；当前配置限制未核实。'}
m['evidence']={'bot_library':'README 明确称为 DeepSeek Harness 表情包知识库，提供检索/发送、MCP、CLI、QQ桥接接口；这证明项目用途，不证明某个已部署bot实际使用。','repository':'https://github.com/Loping151/dsh-nekowhale-stickers','license_evidence':'https://github.com/Loping151/dsh-nekowhale-stickers/blob/main/LICENSE-ASSETS','author':'https://space.bilibili.com/103739','character_design':['https://space.bilibili.com/4168597','https://space.bilibili.com/4456176']}
m['rejected_before_download']={'reason':'优先单人日常和温和反应，排除武器威胁、竖中指、侮辱、项圈/皮鞭及暧昧双人内容；无须用普通emoji补数。','examples':['10N08_迫击炮猫','11N04_上膛','6N06_友好手势','15N03_抓项圈','4N04_皮鞭']}
(root/'manifest.json').write_text(json.dumps(m,ensure_ascii=False,indent=2),encoding='utf-8')
search={'date':'2026-10-31','query':'deepseek stickers','endpoint':'https://api.github.com/search/repositories?q=deepseek+stickers&per_page=10','results_considered':[{'repo':'https://github.com/Loping151/dsh-nekowhale-stickers','decision':'采用：有聊天bot插件用途证据、逐张标注、直接原图和许可边界。'},{'repo':'https://github.com/wutongshu114514/deepseek-mother-Stickers1','decision':'树检索仅README，未发现可直接下载图片，未采用。'},{'repo':'https://github.com/lmy414/ai-girl-stickers','decision':'检索命中，已有更贴合且有来源的完整候选，未继续下载。'},{'repo':'https://github.com/pluveto/DeepSeek-chan','decision':'检索命中，未采用。'}]}
(root/'search-sources.json').write_text(json.dumps(search,ensure_ascii=False,indent=2),encoding='utf-8')
font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',20)
sheet=Image.new('RGB',(1100,1980),'#eaf2fa'); draw=ImageDraw.Draw(sheet)
draw.text((20,12),'小鲸鱼表情候选 / 50 张 / 未接入运行库',font=font,fill='#263b65')
for k,i in enumerate(m['items']):
    x=(k%5)*220; y=(k//5)*190+55
    pic=Image.open(root/'previews'/f'{i["number"]:02d}.png').convert('RGBA')
    sheet.paste(pic,(x+30,y),pic)
    name=i['source_id'].split('_',1)[-1]
    draw.text((x+8,y+158),f'{i["number"]:02d} {name[:8]}',font=font,fill='#263b65')
draw.text((20,1960),'作者：可以叫我云大人/雾雪 · kiriyuki.com · 非商候选',font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',14),fill='#263b65')
sheet.save(root/'contact-sheet.jpg',quality=88)
css='''*{box-sizing:border-box}body{margin:0;background:#eaf2fa;color:#263b65;font-family:"Microsoft YaHei","PingFang SC",sans-serif}main{max-width:1280px;margin:auto;padding:32px 22px}header{max-width:900px}h1{font-size:36px;line-height:1.3;margin:0 0 14px}p{line-height:1.8;margin:10px 0}a{color:#294e94}input,select,button{font:inherit;padding:11px;border:1px solid #526eaa;border-radius:6px;background:white;color:#263b65}input{min-width:260px;flex:1}button{cursor:pointer}button:focus-visible,a:focus-visible,input:focus-visible,select:focus-visible{outline:3px solid #526eaa;outline-offset:4px}.controls{display:flex;gap:10px;flex-wrap:wrap;align-items:center;margin:24px 0}.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:24px 16px}article{min-width:0;background:white;padding:14px;border-radius:10px}article[hidden]{display:none}.picture{display:block;width:100%;border:0;padding:0;background:#f2f6fc;min-height:180px}.picture img{height:180px;width:100%;object-fit:contain}h2{font-size:18px;margin:12px 0 5px}.tags{font-size:13px;line-height:1.7;min-height:44px}.small{font-size:12px;line-height:1.7}summary{cursor:pointer}details{margin:18px 0}footer{margin-top:35px;max-width:900px}.empty{padding:30px} @media(max-width:480px){main{padding:22px 14px}h1{font-size:28px}.grid{grid-template-columns:repeat(2,minmax(0,1fr));gap:10px}article{padding:9px}.picture img{height:140px}.picture{min-height:140px}h2{font-size:15px}input{min-width:100%}}'''
parts=['<!doctype html><html lang="zh-CN"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>小鲸鱼表情候选 · 50张</title><style>'+css+'</style><main><header><h1>小鲸鱼，今天用哪张？</h1><p>50 张 DeepSeek 鲸鱼娘日常反应 GIF。只做候选筛选，未放入启用目录，未修改配置，未重启，也未发送微信。</p><p>原图合计 61.20 MiB；默认显示静态缩略图，点击图片播放本地动画，再点停止。缩略图内嵌在本 HTML，单独打开也能浏览；播放和打开原图需要保留旁边的候选文件夹。</p><details><summary>作者、来源与许可边界</summary><p>作者：<a href="https://space.bilibili.com/103739">可以叫我云大人/雾雪</a>，原图来自 <a href="https://kiriyuki.com">kiriyuki.com</a>。来源索引为 <a href="https://github.com/Loping151/dsh-nekowhale-stickers">dsh-nekowhale-stickers</a>，仓库明确面向 DeepSeek Harness 表情包工具，但不据此断言任何具体已部署 bot 使用过。</p><p>'+html.escape(m['license'])+'</p><p><a href="https://github.com/Loping151/dsh-nekowhale-stickers/blob/main/LICENSE-ASSETS">查看精确许可说明</a>；原图保留原始字节，不裁剪署名、不重编码。</p></details></header><div class="controls"><input id="search" aria-label="搜索表情名称情绪场景" placeholder="搜索：摸鱼、饿了、困惑、委屈…"><select id="category" aria-label="筛选类别"><option value="">全部类别</option>']
for cat in m['category_counts']: parts.append('<option>'+html.escape(cat)+'</option>')
parts.append('</select><button id="stop">停止全部动画</button><span id="count" aria-live="polite">50 张</span></div><section class="grid">')
for i in m['items']:
    n=i['number']; name=i['source_id'].split('_',1)[-1]; img='data:image/png;base64,'+base64.b64encode((root/'previews'/f'{n:02d}.png').read_bytes()).decode()
    text=' '.join([name,i['emotion'],i['category'],*i['tags'],i['use']]); e=html.escape
    parts.append(f'<article data-search="{e(text,quote=True)}" data-category="{e(i["category"],quote=True)}"><button class="picture" aria-label="播放 {e(name)} 动画" aria-pressed="false" data-gif="{e(i["filename"],quote=True)}"><img src="{img}" alt="{e(name)}" loading="lazy"></button><h2>{n:02d} {e(name)}</h2><p class="tags">{e(i["emotion"])} / {e("、".join(i["tags"]))}</p><p class="small">{e(i["use"])}</p><p class="small">{i["width"]} × {i["height"]} · {i["frames"]}帧 · {i["bytes"]/1048576:.2f} MiB<br><a href="{e(i["filename"],quote=True)}">打开本地原图</a>　<a href="{e(i["original_url"],quote=True)}">原始来源</a></p></article>')
parts.append('</section><p class="empty" hidden>没有匹配的表情，试试“摸鱼”“开心”或清空筛选。</p><footer><p>审查方式：50 张均通过 GIF 格式、大小、尺寸、帧数和完整逐帧解码校验；SHA-256 无重复，逐文件匹配上游 SHA-1 前缀。已实际查看每张首、中、末帧联系图，未见明显广告、严重水印、色情、仇恨或恶意攻击。人工审图为抽帧，并非逐帧内容审核。</p><p>“啧啧啧”“你小子”等只作友善轻度调侃。含红酒杯的“绷住”是憋笑场景。GIF可能带闪光效果，默认不播放。</p><p><a href="manifest.json">完整来源及哈希清单</a>　<a href="search-sources.json">检索来源记录</a>　<a href="contact-sheet.jpg">50张静态联系图</a></p></footer></main><script>const cards=[...document.querySelectorAll("article")];function filter(){const q=document.querySelector("#search").value.trim().toLowerCase(),c=document.querySelector("#category").value;let n=0;cards.forEach(a=>{a.hidden=!(a.dataset.search.toLowerCase().includes(q)&&(!c||c===a.dataset.category));if(!a.hidden)n++;else stop(a.querySelector(".picture"));});document.querySelector("#count").textContent=n+" 张";document.querySelector(".empty").hidden=n!==0;}function stop(b){if(b.dataset.still){b.querySelector("img").src=b.dataset.still;b.setAttribute("aria-pressed","false");}}document.querySelector("#search").addEventListener("input",filter);document.querySelector("#category").addEventListener("change",filter);document.querySelectorAll(".picture").forEach(b=>{b.dataset.still=b.querySelector("img").src;b.addEventListener("click",()=>{if(b.getAttribute("aria-pressed")==="true")stop(b);else{b.querySelector("img").src=b.dataset.gif;b.setAttribute("aria-pressed","true");}});});document.querySelector("#stop").addEventListener("click",()=>document.querySelectorAll(".picture").forEach(stop));</script></html>')
(root/'index.html').write_text(''.join(parts),encoding='utf-8')
print(json.dumps({'count':len(m['items']),'categories':m['category_counts'],'bytes':m['total_image_bytes'],'html_bytes':(root/'index.html').stat().st_size},ensure_ascii=False))
