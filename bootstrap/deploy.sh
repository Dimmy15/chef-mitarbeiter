#!/bin/bash

# Usage: ./deploy.sh [host]

host="${1}"

# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
ssh-keygen -R "${host#*@}" 2> /dev/null

tar -cjv --exclude '.git' . | ssh -o 'StrictHostKeyChecking no' root@"$host" '
set -x
sudo rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar -xjv &&
sudo bash ./bootstrap/install.sh'