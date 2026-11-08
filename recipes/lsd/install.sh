#!/usr/bin/bash

# requires aliases recipe.

FILE="$CACHE_DIR/lsd.deb"
URL="https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd-musl_1.2.0_amd64.deb"

if ! [[ -f "$FILE" ]] ; then
    wget -q "$URL" -O "$FILE"
fi

set -x

upload "$FILE" "/tmp/lsd.deb"
cmd 'dpkg -i "/tmp/lsd.deb"'

# cmd "apt install lsd"
cmd "mkdir -p /etc/lsd"
upload lsd.yaml /etc/lsd/config.yaml

cmd "mkdir -p /home/$VM_LOGIN/.config/lsd/"
cmd "ln -s /etc/lsd/config.yaml /home/$VM_LOGIN/.config/lsd/config.yaml"

cmd "echo \"alias ls='lsd'\" >> /home/$VM_LOGIN/.bash_aliases"
#cmd "echo \"alias ls='lsd'\" >> /etc/profile.d/aliases.sh"