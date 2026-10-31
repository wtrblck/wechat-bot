"""Bounded read-only proof of native emoji upload file reads; never sends."""
import argparse
from pe_image import PEImage
from profile import DLL, ROOT, make_config
from probe import Journal, run_probe


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', required=True, type=int)
    parser.add_argument('--seconds', default=30, type=int)
    args = parser.parse_args()
    config = make_config(seconds=args.seconds)
    image = PEImage(DLL)
    rva = 0x3a2520
    if image.owner(rva)['begin'] != rva:
        raise ValueError('not a native function entry')
    config.update(sites=[dict(name='emoji_upload_file_read', rva=rva,
                             bytes=list(image.read_rva(rva, 32)))],
                  callback_backend='native', capture_test=True, capture_kind='emoji_file_read')
    return run_probe(args.pid, config, Journal(ROOT / 'runs/gif-upload-fix/diagnostics'))


if __name__ == '__main__':
    raise SystemExit(main())
