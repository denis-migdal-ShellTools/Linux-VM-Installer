export VM_ASSETS="screenrc"

cat << EOF >> "$ISODIR/install/postinstall.sh"

# screenrc
cp /cdrom/install/screenrc -t /target/etc/

'
EOF