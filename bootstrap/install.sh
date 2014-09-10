#!/bin/bash

# This runs as root on the server

chef_binary=$(which chef-solo)

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    aptitude update &&
    apt-get -o Dpkg::Options::="--force-confnew" \
        --force-yes -fuy dist-upgrade &&
    # Install Ruby and Chef
    aptitude install -y ruby1.9.1 ruby1.9.1-dev build-essential git&&
    sudo gem1.9.1 install --no-rdoc --no-ri chef berkshelf
fi &&

berks install
berks vendor
$chef_binary -c ./bootstrap/solo.rb -j ./bootstrap/solo.json