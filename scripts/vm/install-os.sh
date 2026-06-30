#!/usr/bin/bash

source $(dirname $(readlink -f "$0"))/../core/base.sh

EXTRA_KERNEL_PARAMETERS="auto=true preseed/file=/cdrom/preseed.cfg priority=critical quiet splash noprompt noshell automatic-ubiquity --"

if [[ "$VM_DEBUG" == "true" ]] ; then
    EXTRA_KERNEL_PARAMETERS="DEBCONF_DEBUG=5 $EXTRA_KERNEL_PARAMETERS"
else
    HEADLESS="--type headless"
fi

POST_INSTALL=$(cat "$POSTINSTALL_FILE" | sed "s/'/'\\\\''/g")

KEY=$(cat "$WORKSPACE_DIR/keys/automation.pub")

# Without debug:
# "/target/bin/bash -c '$POST_INSTALL' _ '$KEY'"
# With debug:
# "echo '$POST_INSTALL' > /target/postinstall && /target/bin/bash /target/postinstall '$KEY'"

VBoxManage unattended install "$VM_NAME" \
    --iso "$ISO_FILE" \
    --install-additions \
    --script-template="$PRESEED_FILE" \
    --post-install-command="echo '$POST_INSTALL' > /target/postinstall && /target/bin/bash /target/postinstall '$KEY'" \
    --extra-install-kernel-parameters="$EXTRA_KERNEL_PARAMETERS" \
    --user "$VM_LOGIN"

# Start VM for install
VBoxManage startvm "$VM_NAME" $HEADLESS

# Waiting end of installation
VBoxManage guestproperty wait "$VM_NAME" VMReady

VBoxManage snapshot "$VM_NAME" take "base-install"