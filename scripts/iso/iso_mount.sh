#!/usr/bin/bash

ISO_FILE="$1"
ISO_DIR="$2"

mkdir -p "$ISO_DIR"

## archivemount doesn't produce an iso file we can use.
archivemount -o readonly "$ISO_FILE" "$ISO_DIR"

# alternative:
# bsdtar -xf "$ISO_PATH" -C "$ISO_PATCHED_DIR"
# chmod -R +w "$ISO_PATCHED_DIR"