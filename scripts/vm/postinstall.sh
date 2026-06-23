#!/usr/bin/bash

TARGET="/target"

####
# autorise root login for the installation step...
####

sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' $TARGET/etc/ssh/sshd_config

mkdir $TARGET/root/.ssh

cat <<-EOF > $TARGET/root/.ssh/authorized_keys
	ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCLj5tAoyG1xabz4OPOm3IFW/pn8ewVzuipx+NwhWogDXLbBAY6ls6AlJM6CwUFJRpMn16T5M5zCU2CGyOd8ZS2/6yyieRCjreQSY9oqhJrpOefLGV4gC3TGKQe8f+ttGQ1mnAzmNnI88bxFJvpq++dTREhfIpThb2csnrjs3m0YC3rmP3FiWrQAVvTf6uy4XFoTZ2/TSeIszuPmGZn+2esNo6SMtPIAAKDqphQEX4y8er7lsyzAwKNnSJGkYCQ/BjxxIVdrHG/FZdSITXya9Vi7k8Ui8R/cXP07HFO51F2wUPvxTgYBPN9GYwLhxWgju06TogOuHwrIEA7/wIqP2ENz7XWveSkUVOtdZEtYfB5Kwp2yfW4oA687P7z947Cqq4d6hQ5kdM3GcOuW4qz23/uWOaT2ocPRVcN1OvjWpqIlG8A46gf2UNxhDtBwHdvlWSG2KQppF8SEWXpwOc44KEM/hYtC2SfHllJDV/fFsA5xXj+MUozQv0GT68ErZTYe/X/WORm3wKc2ne0iWFSf0bVcT/EOtqknh8lEr1O9lBWrF0LNE5vcS5SNUaF9ueOkIRKf2dBBI1IfdsgAjKXF/vOqKYiyHINqLY5GJs/XGCvyHIFXCWfSDDLMfUNroyXdB1CygbpR91gDxRu/WlgFweR31LXwBegQ6Tlf4vUAeP/gw== demigda@demigda-Latitude-5400
	EOF

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