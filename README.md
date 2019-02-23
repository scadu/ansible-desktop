# This repository contains an Ansible role for provisioning Ubuntu machines

Tested on Ubuntu 18.04.

## Usage

### Available installation types

    - wsl
    - desktop

`install_type` should be adjusted in the `deploy.yml` playbook.

1. Adjust `{{ install_type}}_config.yml`

2. Run deploy script

    ```
    ./deploy.sh
    ```

3. Go grab a cup of $drink

4. Voilà!
