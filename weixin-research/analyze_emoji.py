"""Offline pinned type-47 send anchor inventory; no process attach."""
import json,re,struct
from pe_image import PEImage
from profile import DLL,ROOT,SHA256

def main():
 image=PEImage(DLL)
 assert image.sha256==SHA256
 pattern=re.compile(rb'(send.{0,65}(emoticon|emoji|sticker)|(emoticon|emoji|sticker).{0,65}send|EmoticonMessage|EmojiMessage)',re.I)
 anchors=[]
 for match in re.finditer(rb'[\x20-\x7e]{7,400}',image.data):
  if not pattern.search(match.group()):continue
  for section in image.sections:
   if section['raw']<=match.start()<section['raw']+section['size'] and not section['flags']&0x20000000:
    anchors.append(dict(text=match.group().decode('ascii'),rva=section['rva']+match.start()-section['raw'],refs=[]));break
 targets={a['rva']:a for a in anchors}
 for section in image.sections:
  if not section['flags']&0x20000000:continue
  code=image.data[section['raw']:section['raw']+section['size']]
  for match in re.finditer(rb'(?=([\x48-\x4f][\x8d\x8b][\x05\x0d\x15\x1d\x25\x2d\x35\x3d].{4}))',code,re.S):
   rva=section['rva']+match.start();dest=rva+7+struct.unpack_from('<i',match.group(1),3)[0]
   if dest in targets:targets[dest]['refs'].append(dict(rva=rva,function=image.owner(rva)))
 directory=ROOT/'runs/emoji';directory.mkdir(parents=True,exist_ok=True)
 (directory/'send-anchors.json').write_text(json.dumps(anchors,indent=2),encoding='utf-8')
 print(json.dumps([dict(text=a['text'],refs=a['refs']) for a in anchors if a['refs']],indent=2))
if __name__=='__main__':main()
