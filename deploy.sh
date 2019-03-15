#!/usr/bin/env bash

if ! command -v ansible >/dev/null 2>&1
then
  sudo apt-add-repository ppa:ansible/ansible -y
  sudo apt update
  sudo apt install ansible -y
fi

ansible-playbook deploy.yml -vv -D -K
