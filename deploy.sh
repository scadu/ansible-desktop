#!/usr/bin/env bash
set -eu -o pipefail

printf "Preparing environment...\n"
sudo apt update && sudo apt install -y python3-{dev,pip,venv,apt}
# shellcheck disable=SC1091
python3 -m venv .venv && source ./.venv/bin/activate
pip3 install -q -r requirements.txt --no-cache-dir
ansible-playbook deploy.yml -e "target=$1" -D -K

printf "Cleaning up...\n"
rm -rf .venv

printf "Voilà!\n"
