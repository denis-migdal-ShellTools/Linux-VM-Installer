#!/usr/bin/bash

TARGET="/target"
KEY="$1"

####
# autorise root login for the installation step...
####

sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' $TARGET/etc/ssh/sshd_config

mkdir $TARGET/root/.ssh

sed -i 's|^#AuthorizedKeysFile.*|AuthorizedKeysFile /etc/ssh/authorized_keys .ssh/authorized_keys|' $TARGET/etc/ssh/sshd_config
echo "$KEY" > $TARGET/etc/ssh/authorized_keys

####
# VMReady: notify VBox when the VM is ready.
####

cat <<- EOF > $TARGET/etc/systemd/system/VMReady.service
	[Unit]
	Description=VMReady
	After=sshd.target

	[Service]
	Type=simple
	User=root
	ExecStart=/usr/bin/VBoxControl guestproperty set VMReady true

	[Install]
	WantedBy=multi-user.target
	EOF

ln -s /etc/systemd/system/VMReady.service $TARGET/etc/systemd/system/multi-user.target.wants/VMReady.service

####
# GRUB: don't need the timeout.
####

sed -i 's#GRUB_TIMEOUT=5#GRUB_TIMEOUT=0#' $TARGET/etc/default/grub
echo "GRUB_TIMEOUT_STYLE=hidden" >> $TARGET/etc/default/grub

chroot $TARGET update-grub
#in-target update-grub

# dunno why we need to manually edit /boot/grub/grub.cfg
sed -i 's#timeout=5#timeout=0#g' $TARGET/boot/grub/grub.cfg
sed -i 's#timeout_style=menu#timeout_style=hidden#g' $TARGET/boot/grub/grub.cfg