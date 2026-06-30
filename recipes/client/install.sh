#!/usr/bin/bash

mkdir -p ~/.ssh/keys
ssh-keygen -N "" -f ~/.ssh/keys/ASLTerm

mkdir -p ~/.ssh/config.d
LINE='Include ~/.ssh/config.d/*'
grep -Fxq "$LINE" ~/.ssh/config || sed -i "1i $LINE" ~/.ssh/config

ssh-copy-id -i ~/.ssh/keys/ASLTerm.pub -o StrictHostKeyChecking=accept-new -p 8022 $USER@scep.prox.dsi.uca.fr

cat <<- EOF > ~/.ssh/config.d/SCEP
	Host SCEP
	    User $USER
	    HostName scep.prox.dsi.uca.fr
	    Port 8022
	    IdentityFile ~/.ssh/keys/ASLTerm
	EOF

# read -p "Saisissez l'IP de la machine : " IP
IP=10.172.2.18

ASLUser=user
# zeus 

# TODO: initial connexion...

cat <<- EOF > ~/.ssh/config.d/ASLTerm
	Host ASLTerm
	    User $ASLUser
	    HostName $IP
	    Port 22
	    IdentityFile ~/.ssh/keys/ASLTerm
		ProxyJump SCEP
	EOF

#####
# launcher...
#####

DIR=$(dirname $(readlink -f "$0"))
VM_ICON="$DIR/ASLTerm.svg"

cat <<- EOF > ~/.local/share/applications/ASLTerm.desktop
	[Desktop Entry]
	Name=ASLTerm
	Exec=xfce4-terminal --title ASLTerm --color-bg "#400000" --hide-menubar -x ssh ASLTerm
	Icon=$VM_ICON
	Terminal=false
	Type=Application
	Categories=GTK;System;TerminalEmulator;
	StartupNotify=true
	EOF