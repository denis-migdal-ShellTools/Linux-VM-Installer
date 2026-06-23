#!/usr/bin/bash

ISO_DIR="$1"

## Should be ro, no need for safe umount.
## cf https://github.com/cybernoid/archivemount/issues/38
fusermount -u "$ISO_DIR"