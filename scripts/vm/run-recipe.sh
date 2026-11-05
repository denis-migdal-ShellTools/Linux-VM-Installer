#!/usr/bin/bash

# TODO: execute-recipe (cmd)...

source $(dirname $(readlink -f "$0"))/../core/base.sh

RECIPE="$2"

VBoxManage startvm "$VM_NAME" $HEADLESS || true

IS_READY=`VBoxManage guestproperty get "$VM_NAME" VMReady | grep -v WARNING`
if [[ "$IS_READY" == "true" ]] ; then
    VBoxManage guestproperty wait "$VM_NAME" VMReady
fi

CONTROL_PATH=~/.ssh/cm-root@localhost:8022

ssh -M -S "$CONTROL_PATH" -fN -p $VM_SSH_PORT -i "$WORKSPACE_DIR/keys/automation" -o StrictHostKeyChecking=accept-new root@localhost

# ssh -S ~/.ssh/cm-%r@%h:%p user@host
# scp -o ControlPath=~/.ssh/cm-%r@%h:%p fichier user@host:/tmp

cmd() {
    ssh -S "$CONTROL_PATH" -p $VM_SSH_PORT root@localhost "$1"
}

upload () {

    SRC="$1"
    if ! [[ "$SRC" == /* ]]; then
        SRC="$ROOT/$1"
    fi

    scp -o ControlPath="$CONTROL_PATH" -P $VM_SSH_PORT "$SRC" root@localhost:"$2"
}

export VM_LOGIN
export VM_SSH_PORT
export CONTROL_PATH
export CACHE_DIR
export -f cmd
export -f upload


echo "=== $RECIPE ==="

export ROOT="$WORKSPACE_DIR/recipes/$RECIPE"
"$ROOT/install.sh"

ssh -S ~/.ssh/cm-%r@%h:%p -O exit -p $VM_SSH_PORT root@localhost

echo "SSH done"