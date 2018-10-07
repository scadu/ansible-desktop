#!/usr/bin/env bash

if ! [ -x "$(command -v ansible)" ]; then
  echo 'Ansible not found. Installing...' >&2
  sudo dnf install -y ansible
fi

ansible-playbook deploy.yml
