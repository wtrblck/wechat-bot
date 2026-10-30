# Third-party notices

`weixin-research/vendor/wechatauto/db.py` and `media.py` originate from
[fanyuantaier/wechatauto-replica](https://github.com/fanyuantaier/wechatauto-replica).
Their Apache-2.0 license and original module headers are retained. This project
uses only the database/media readers, not its UI automation stack.
Project-specific integration lives outside the vendor directory. The exact
upstream revision was not recorded in the original local research snapshot.
Sample identifiers in db.py were anonymized for this public export; a modification
notice is included in that file and in the vendor NOTICE.md.

JavaScript packages are installed using `agent/pnpm-lock.yaml`; Python packages
are listed in `weixin-research/requirements.txt` and `requirements-media.txt`.
They are not bundled and retain their own licenses. FFmpeg distribution details
are supplied by imageio-ffmpeg.

WeChat binaries are not included or licensed by this project. Version profiles
and static analysis files are compatibility research data.
