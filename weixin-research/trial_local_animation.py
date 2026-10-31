"""Explicit native local-GIF trial; only the authorized previous test contact."""
import argparse
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from active_send import config_for
from policy import SendPolicy
from probe import Journal, run_probe
from process_discovery import find_main_pid
from profile import DLL

parser = argparse.ArgumentParser()
parser.add_argument('--send', action='store_true')
parser.add_argument('--library', action='store_true')
args = parser.parse_args()
recipient = 'wxid_u3yyhe3yrwh122'
source = (ROOT.parent / 'agent/data/sandbox/d009e792720d08a4a2b503ebac6652bf972dff23a03a853f8fbd3f9d4730cfab/outgoing/47279dcbee946a09dfb6db0c863659f0e63aa64decc54c0dc8108b42fd498e80/sticker.gif'
          if args.library else ROOT / 'runs/emoji/incoming.gif')
policy = SendPolicy(recipients=(recipient,), media_roots=(source.parent,))
config = config_for('image', path=str(source), recipient=recipient, policy=policy, seconds=5)
if not config['active_experiment'].get('local_emoji'):
    raise SystemExit('Refusing trial: verified native local emoji preparation is unavailable')
if not args.send:
    config['active_experiment']['thread_source'] = '#define EMOJI_BUILD_ONLY 1\n' + config['active_experiment']['thread_source']
    config['active_experiment']['construction_only'] = True
config['finish_after_dispatch'] = True
result = run_probe(find_main_pid(DLL), config, Journal(ROOT / 'runs/animation-trial'))
raise SystemExit(result)
