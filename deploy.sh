#!/usr/bin/env bash

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible -y

ansible-playbook deploy.yml -vv -D -K
