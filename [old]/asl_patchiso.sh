export VM_ASSETS="screenrc bin lsd.yaml keys/LVMI.pub VMReady.service"
#default VM_EXTRA_PACKAGES ""

# sudo
# screen
# btop

cat << EOF >> "$ISODIR/install/postinstall.sh"

# screenrc
cp /cdrom/install/screenrc -t /target/etc/

# cmd

chroot /target /bin/bash -c '
# fix env variables
export HOME=/root
export PATH="\$PATH:/usr/local/bin"

set -x

# sudo
usermod zeus -G sudo -a

# tldr
pipx install pipx
apt purge -y --autoremove pipx
/root/.local/bin/pipx install --global pipx
hash -r
pipx install --global tldr

# cache (> 100 years)
echo "TLDR_CACHE_MAX_AGE=1000000" >> /etc/environment
mkdir /usr/local/share/tldr
mkdir /home/zeus/.cache
chown -R zeus:zeus /home/zeus/.cache
ln -s /usr/local/share/tldr /home/zeus/.cache/tldr
ln -s /usr/local/share/tldr /root/.cache/tldr
tldr -u

'
EOF