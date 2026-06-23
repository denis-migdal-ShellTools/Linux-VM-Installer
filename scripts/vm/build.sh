#!/usr/bin/bash

source $(dirname $(readlink -f "$0"))/../core/base.sh

if [[ ! -f "$ISO_FILE" ]] ; then
    wget -O "$ISO_FILE" "$ISO_URL"
fi

run vm/create
run vm/preseed
run vm/install-os
run vm/configure