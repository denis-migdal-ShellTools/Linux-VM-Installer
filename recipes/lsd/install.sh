#!/usr/bin/bash

# requires aliases recipe.

set -x

cmd apt install lsd
cmd mkdir -p /etc/lsd
upload lsd.yml /etc/lsd/config.yaml

cmd mkdir -p /home/$VM_LOGIN/.config/lsd/
cmd ln -s /etc/lsd/config.yaml /home/$VM_LOGIN/.config/lsd/config.yaml
cmd echo "alias ls='lsd'" \>\> /etc/profile.d/aliases.sh