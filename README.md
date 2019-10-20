# Ansible role for provisioning Ubuntu-based machines and WSL environments

Tested on Ubuntu 18.04 LTS.

## Usage

### Available install types

    - wsl
    - desktop

`install_type` should be adjusted in the `deploy.yml` playbook.

1. Adjust `{{ install_type }}_config.yml`

2. Run deploy script

    ``` sh
    ./deploy.sh
    ```

3. Go grab a cup of $drink

4. Voilà!
