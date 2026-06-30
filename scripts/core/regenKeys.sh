#!/usr/bin/bash

WORKSPACE_DIR=$( readlink -f $(dirname $(readlink -f "$0"))/../.. )
KEYDIR="$WORKSPACE_DIR/keys/"

mkdir -p "$KEYDIR"

ssh-keygen -N "" -f "${KEYDIR}automation"