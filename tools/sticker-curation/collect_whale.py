import json, sys, subprocess, hashlib, html, base64, concurrent.futures
from pathlib import Path
from urllib.parse import quote
from PIL import Image, ImageDraw, ImageFont
sys.stdout.reconfigure(encoding='utf-8')
root = Path(sys.argv[1]).resolve()
source = root / 'source-kiriyuki'
metadata_path = source / 'upstream-meta.json'
if not metadata_path.exists(): metadata_path = root / 'source-github-loping151' / 'upstream-meta.json'
meta = json.loads(metadata_path.read_text(encoding='utf-8'))
catalog = json.loads((source / 'upstream-catalog.json').read_text(encoding='utf-8'))
codes = '10N01 10N03 10N05 10N11 11N03 11N05 11N06 11N08 11N09 11N11 11N12 12N01 12N02 12N03 12N05 12N07 12N08 12N11 13N03 13N06 13N07 13N10 13N11 14N03 14N04 14N08 14N10 15N01 15N05 15N10 15N12 16N01 16N02 16N07 16N08 16N12 2N07 2N09 2N10 2N11 3N04 3N05 4N05 5N05 6N12 7N08 8N09 9N11 EX69 N01'.split()
assert len(codes) == 50
bycode = {x['code']: x for x in catalog['items'] if x['pack']=='大肥鱼' and not x['variant']}
byid = {x['id']: x for x in meta['stickers']}
license_text = '图片不属于仓库 Apache-2.0 或 CC BY-NC 4.0 授权范围；仓库 LICENSE-ASSETS 声明可非商业分享但须保留原作者链接及网站，禁止收费或其他商业用途。仅候选，实际接入或再分发前请核实原作者权利与条件。标签元数据为 CC BY-NC 4.0。'
repo = 'https://github.com/Loping151/dsh-nekowhale-stickers'
def fetch(pair):
    n,code = pair
    item = bycode[code]; m = byid[item['id']]
    url = 'https://kiriyuki.com' + catalog['gif_base'] + '/' + quote(item['pack']) + '/' + quote(item['file']) + '?h=' + item['hash']
    filename = f'{n:02d}_{m["emotion"]}_{item["name"]}.gif'
    path = source / filename
    if not path.exists():
        subprocess.run(['curl','--proto','=https','--proto-redir','=https','-L','--fail','--silent','--show-error','--max-time','90','--max-filesize','8388608',url,'-o',str(path)],check=True)
    data=path.read_bytes()
    assert 0 < len(data) <= 8*1024*1024
    assert data[:6] in (b'GIF87a',b'GIF89a')
    assert hashlib.sha1(data).hexdigest()[:12] == item['hash'], filename
    with Image.open(path) as im:
        assert im.format == 'GIF' and im.size == (item['w'],item['h'])
        frames=im.n_frames
        assert frames == item['frames']
        # Decode every frame, not only the header.
        for f in range(frames): im.seek(f); im.load()
        for j,f in enumerate([0,frames//2,frames-1]):
            im.seek(f); pic=im.convert('RGBA'); pic.thumbnail((180,180))
            bg=Image.new('RGB',(180,180),'#edf2f8'); bg.paste(pic,((180-pic.width)//2,(180-pic.height)//2),pic)
            bg.save(root/'previews'/f'{n:02d}-{j}.jpg',quality=85)
        im.seek(frames//2); pic=im.convert('RGBA'); pic.thumbnail((160,160))
        pic.save(root/'previews'/f'{n:02d}.png')
    print(f'{n:02d} {item["name"]} {len(data)} bytes',flush=True)
    return {'number':n,'filename':str(path.relative_to(root)).replace('\\','/'),'original_url':url,'source_page':'https://kiriyuki.com/showcase?p='+quote('大肥鱼'),'repository':repo,'source_id':item['id'],'author':'可以叫我云大人/雾雪','author_url':'https://space.bilibili.com/103739','author_site':'https://kiriyuki.com','license':license_text,'license_evidence':repo+'/blob/main/LICENSE-ASSETS','sha256':hashlib.sha256(data).hexdigest(),'upstream_sha1_prefix':item['hash'],'bytes':len(data),'format':'GIF','width':item['w'],'height':item['h'],'frames':frames,'emotion':m['emotion'],'tags':m['tags'],'use':m['use'],'description':m['desc'],'visual_review':'pending','downloaded_at':'2026-10-31'}
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
    items=sorted(pool.map(fetch,enumerate(codes,1)),key=lambda x:x['number'])
assert len({i['sha256'] for i in items}) == 50
font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',18)
for page in range(5):
    sheet=Image.new('RGB',(1120,1150),'white'); draw=ImageDraw.Draw(sheet)
    for pos,item in enumerate(items[page*10:(page+1)*10]):
        x=(pos%2)*560; y=(pos//2)*230
        draw.text((x+5,y+3),f"{item['number']:02d} {item['source_id'].split('_',1)[-1]} / {item['emotion']}",font=font,fill='black')
        for j in range(3):sheet.paste(Image.open(root/'previews'/f'{item["number"]:02d}-{j}.jpg'),(x+j*184,y+36))
    sheet.save(root/'previews'/f'contact-{page+1}.jpg',quality=90)
(root/'manifest.json').write_text(json.dumps({'candidate_only':True,'enabled':False,'count':len(items),'total_image_bytes':sum(i['bytes'] for i in items),'source':repo,'license':license_text,'items':items},ensure_ascii=False,indent=2),encoding='utf-8')
print('DONE',len(items),sum(i['bytes'] for i in items))
