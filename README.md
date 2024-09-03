# Ansible role for provisioning Fedora-based desktops

Currently used with Fedora 40.
Review before running anything from that repo. 

You've been warned.

## Prerequirements
`ansible` and `python3-psutil` packages

## Usage

```bash
./deploy
```
Above will ask you for the config. If left empty, it will use defaults.
Otherwise, it would map provided config name to `vars/$config.yaml`.