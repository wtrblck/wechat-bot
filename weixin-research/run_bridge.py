"""Launch the bridge with an explicit local policy, including empty strings.

Windows PowerShell 5/.NET Framework removes empty process environment values.
Load the policy inside the Python interpreter which runs the service instead.
"""
import argparse
import json
import os
from pathlib import Path
import re
import runpy
import sys


def apply_policy(path, environ=None):
    environ = os.environ if environ is None else environ
    policy = json.loads(Path(path).read_text(encoding='utf-8-sig'))
    if not isinstance(policy, dict) or any(
        not re.fullmatch(r'WECHAT_[A-Z0-9_]+', key) or not isinstance(value, str)
        for key, value in policy.items()
    ):
        raise ValueError('invalid local bridge policy')
    # Validate every entry before mutating anything. In-memory os.environ retains
    # the explicit empty value even where Windows' native environment omits it.
    for key, value in policy.items():
        environ[key] = value


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--policy', required=True)
    parser.add_argument('--config', required=True)
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--seconds', type=int)
    args = parser.parse_args(argv)
    if args.seconds is not None and not 1 <= args.seconds <= 86400:
        parser.error('seconds must be 1..86400')
    apply_policy(args.policy)
    script = Path(__file__).resolve().with_name('bridge_service.py')
    sys.path.insert(0, str(script.parent))
    sys.argv = [str(script), '--config', str(Path(args.config).resolve())]
    if args.check:
        sys.argv.append('--check')
    if args.seconds is not None:
        sys.argv.extend(['--seconds', str(args.seconds)])
    runpy.run_path(str(script), run_name='__main__')


if __name__ == '__main__':
    main()
