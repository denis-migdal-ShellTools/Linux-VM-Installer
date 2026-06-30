export VM_ASSETS="screenrc"

# screen
# btop

cat << EOF >> "$ISODIR/install/postinstall.sh"

# screenrc
cp /cdrom/install/screenrc -t /target/etc/

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