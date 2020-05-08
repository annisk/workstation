# Workstation
----------------
This ansible repo sets up a new workstation from scratch on various operating systems.

## Requirements
Supported Operating Systems:
- Ubuntu 18.04+
- RHEL 8+/CentOS 8+/Fedora 32+

Required software (installed by bootstrap):
- python 2.7+
- ansible 2.9.7+

## Running
Run the bootstrap script:
```
./bootstrap.sh
```

To run Ansible standalone:
```
ansible-playbook setup.yml -K
```
