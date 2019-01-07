#!/usr/bin/env bash

export PATH="$HOME/.local/bin:$PATH"

if ! [ -x "$(command -v pip2)" ]; then
  echo 'pip2 not found. Installing...' >&2
  sudo apt install python-pip -y
fi

echo 'Installing Ansible...' >&2
pip2 install virtualenv && pip install --user virtualenv
virtualenv venv && source venv/bin/activate
pip2 install -r requirements.txt

ansible-playbook deploy.yml -vv -D -K
