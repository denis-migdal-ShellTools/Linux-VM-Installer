#!/usr/bin/bash

for FILE in "$ROOT"/files/* ; do
    NAME=$(basename "$FILE")
    upload "files/$NAME" /usr/local/bin/"$NAME"
    cmd chmod +x /usr/local/bin/"$NAME"
done