#!/usr/bin/env bash
set -eu -o pipefail

sudo apt update && sudo apt install software-properties-common -y

if ! command -v ansible >/dev/null 2>&1
then
  sudo apt-add-repository -y -u ppa:ansible/ansible 
  sudo apt install ansible -y
fi

ansible-playbook deploy.yml -D -K
