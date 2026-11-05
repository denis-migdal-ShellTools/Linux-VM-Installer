#!/usr/bin/bash

URL="https://github.com/oberblastmeister/trashy/releases/download/v2.0.0/trash-x86_64-unknown-linux-gnu.tar.gz"

FILE="$CACHE_DIR/trash"

if ! [[ -f "$FILE" ]] ; then
    wget -q -O - "$URL" | tar -xz -C "$CACHE_DIR"
    chmod +x 
fi

upload "$FILE" /usr/bin

cmd "mkdir -p /usr/local/share/man/man1/"
cmd "trash manpage > /usr/local/share/man/man1/trash.1"
cmd mandb

cmd "echo 'alias trash-list=\"trash list -m glob\"' >> ~zeus/.bash_aliases"
cmd "echo 'alias trash-restore=\"trash restore -m glob\"' >> ~zeus/.bash_aliases"
cmd "echo 'alias trash-empty=\"trash empty -m glob\"' >> ~zeus/.bash_aliases"