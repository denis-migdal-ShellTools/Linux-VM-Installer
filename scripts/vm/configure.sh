#!/usr/bin/bash

source $(dirname $(readlink -f "$0"))/../core/base.sh

VBoxManage controlvm "$VM_NAME" poweroff || true
sleep 1
VBoxManage discardstate "$VM_NAME" || true
VBoxManage snapshot "$VM_NAME" restore "base-install"

VBoxManage startvm "$VM_NAME" $HEADLESS

IS_READY=`VBoxManage guestproperty get "$VM_NAME" VMReady | grep -v WARNING`
if [[ "$IS_READY" == "true" ]] ; then
    VBoxManage guestproperty wait "$VM_NAME" VMReady
fi

CONTROL_PATH=~/.ssh/cm-root@localhost:8022

ssh -M -S "$CONTROL_PATH" -fN -p $VM_SSH_PORT -i "$WORKSPACE_DIR/keys/key" -o StrictHostKeyChecking=accept-new root@localhost

# ssh -S ~/.ssh/cm-%r@%h:%p user@host
# scp -o ControlPath=~/.ssh/cm-%r@%h:%p fichier user@host:/tmp

# error...
cmd() {
    ssh -S "$CONTROL_PATH" -p $VM_SSH_PORT root@localhost "$@"
}

upload () {
    scp -o ControlPath="$CONTROL_PATH" -P $VM_SSH_PORT "$ROOT/$1" root@localhost:"$2"
}

export VM_LOGIN
export VM_SSH_PORT
export CONTROL_PATH
export -f cmd
export -f upload


for RECIPE in $RECIPES ; do
    echo "=== $RECIPE ==="

    export ROOT="$WORKSPACE_DIR/recipes/$RECIPE"
    "$ROOT/install.sh"
done

ssh -S ~/.ssh/cm-%r@%h:%p -O exit -p $VM_SSH_PORT root@localhost

echo "SSH done"

VBoxManage snapshot "$VM_NAME" take "fresh-install"