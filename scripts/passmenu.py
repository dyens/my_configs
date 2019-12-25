#!/usr/bin/env python3

"""Script for using dmenu and pass."""

import os
from pathlib import Path
from subprocess import run, PIPE

home = os.environ['HOME']
password_path = Path(home).joinpath('.password-store')


key_paths = password_path.glob('*/*.gpg')

general_passwords = []
url_login_passwords = []

keys = []
for key_path in key_paths:
    key_name = key_path.name[:-4]
    key_parent = key_path.parent.name

    key = '{key_type}/{key_name}'.format(
        key_type=key_parent,
        key_name=key_name,
    )
    keys.append(key)
       
search_string = '\n'.join(keys)

dmenu_process = run(['dmenu'], stdout=PIPE, input=search_string, encoding='ascii')

search_result = dmenu_process.stdout[:-1]  # \n on the end

pass_run_command = ['pass', search_result]

pass_process = run(pass_run_command, stdout=PIPE)

pass_stdout_str = pass_process.stdout.decode('utf-8')

results = {}
for line in pass_stdout_str.split('\n'):
    if not line:
        continue
    key, value = line.split(':')
    value = value.strip()
    key = key.strip()
    results[key] = value


search_string = '\n'.join(results.keys())
dmenu_process = run(['dmenu'], stdout=PIPE, input=search_string, encoding='ascii')
search_result = dmenu_process.stdout[:-1]  # \n on the end

result = results[search_result]
xclip_process = run(['xclip'], input=result, encoding='ascii')
