#!/bin/sh
ansible-playbook infra.yml -i inventory --key-file ../prv/install_rsa
