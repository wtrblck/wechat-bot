"""Read-only identifier resolution for chats the user names by display name.

Sending needs the internal ID (wxid_... or ...@chatroom) and the project must not
guess a target.  This observer copies only messages whose content starts with the
given marker prefix, so the user can send one explicit marker from the phone to
each chat and read the conversation identifier back:

    py -3.14 weixin-research/resolve_targets.py --pid PID --seconds 60

Then, from the phone, send e.g. "wxbot-resolve-contact" to the contact chat and
"wxbot-resolve-group" to the group chat.  No message is sent by this tool and no
unmarked chat content is copied; the target list is intentionally broad because
the identifier is what is being resolved.
"""
import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

from observe_report import summarize
from policy import ObservePolicy
from profile import ROOT, make_config
from probe import Journal, run_probe


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', type=int, required=True)
    parser.add_argument('--seconds', type=int, default=45)
    parser.add_argument('--prefix', default='wxbot-resolve-')
    parser.add_argument('--mode', choices=ObservePolicy.MODES, default='contains',
                        help='contains handles group text that carries a sender prefix')
    args = parser.parse_args()
    if args.pid <= 0:
        parser.error('Invalid PID')
    try:
        observe = ObservePolicy(targets=('*',), prefix=args.prefix, mode=args.mode)
        config = make_config('sync_process_candidate', args.seconds)
    except (ValueError, OSError) as error:
        parser.error(str(error))
    config.update(callback_backend='native', capture_test=True, capture_kind='receive',
                  capture_filter=observe.describe())
    directory = ROOT / 'runs' / 'resolve'
    directory.mkdir(parents=True, exist_ok=True)
    journal = Journal(directory)
    code = run_probe(args.pid, config, journal)
    report = summarize(journal.events, args.prefix)
    output = directory / (datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ') + '-resolve.json')
    output.write_text(json.dumps(dict(prefix=args.prefix, observe=observe.describe(), outcome=code,
                                      observed=report['observed'], identifiers=report['identifiers'],
                                      conversations=report['conversations'],
                                      journal=str(journal.path)), ensure_ascii=False, indent=2),
                      encoding='utf-8')
    print(json.dumps(dict(event='resolve_report', observed=len(report['observed']),
                          identifiers=report['identifiers'], conversations=report['conversations'],
                          report=str(output)), ensure_ascii=False))
    return 0 if report['observed'] else 1


if __name__ == '__main__':
    sys.exit(main())
