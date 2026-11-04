#!/usr/bin/bash

source $(dirname $(readlink -f "$0"))/../core/base.sh

# TODO: opt second arg.

rm "$WORKSPACE_DIR/cache/$VM_NAME.ova"
vboxmanage export "$VM_NAME" --output "$WORKSPACE_DIR/cache/$VM_NAME.ova"
