#TODO...
VM_LOGIN="zeus"

mkdir $TARGET/home/$VM_LOGIN/.ssh
cp $INSTALL/ssh/pubkey -T $TARGET/home/$VM_LOGIN/.ssh/authorized_keys