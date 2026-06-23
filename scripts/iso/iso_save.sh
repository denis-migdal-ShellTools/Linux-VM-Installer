#!/usr/bin/bash

ISO_DIR="$1"
ISO_FILE="$2"

# https://wiki.debian.org/ManipulatingISOs#Appending_Boot_Parameters_to_the_ISO

genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-o "$ISO_FILE" "$ISO_DIR"