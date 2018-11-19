#!/usr/bin/env bash

if ! [ -x "$(command -v ansible)" ]; then
  echo 'Ansible not found. Installing...' >&2
  pip install --user 'ansible==2.6.8'
fi

ansible-playbook deploy.yml -vv -D -K
