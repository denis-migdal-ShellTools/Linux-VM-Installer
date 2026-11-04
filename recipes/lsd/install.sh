#!/usr/bin/bash

# requires aliases recipe.

URL="https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd-musl_1.2.0_amd64.deb"

set -x

DEB=$(mktemp)
wget "$URL" -O
dpgk -i "$DEB"

# cmd "apt install lsd"
cmd "mkdir -p /etc/lsd"
upload lsd.yaml /etc/lsd/config.yaml

cmd "mkdir -p /home/$VM_LOGIN/.config/lsd/"
cmd "ln -s /etc/lsd/config.yaml /home/$VM_LOGIN/.config/lsd/config.yaml"

cmd "echo \"alias ls='lsd'\" >> /home/$VM_LOGIN/.bash_aliases"
#cmd "echo \"alias ls='lsd'\" >> /etc/profile.d/aliases.sh"