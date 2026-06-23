#!/usr/bin/bash

set -e
set -x

TEMPLATE_NAME="$1"
WORKSPACE_DIR=$( readlink -f $(dirname $(readlink -f "$0"))/../.. )
TEMPLATE_DIR="${WORKSPACE_DIR}/vm-templates/${TEMPLATE_NAME}"

default() {
  if [ ! -v $1 ] ; then
    declare -g $1="$2"
  fi
}

run() {
  "$WORKSPACE_DIR/scripts/$1.sh" "$VM_NAME"
}

source "$TEMPLATE_DIR/config.env"
source "$WORKSPACE_DIR/scripts/core/config.env"