#!/usr/bin/env bash

SCRIPT=$(basename "$0")
DIR=$PWD
cd "$DIR"

echo Creating links...
for FILE in *
do
    if [ "$FILE" = "$SCRIPT" ] || [ "$FILE" = "setup_vim.sh" ] || [ "$FILE" = "README.md" ]; then
        continue
    fi

    echo "-- $FILE"

    DEST="$HOME/.$FILE"
    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        echo "$DEST exists."
    else
        ln -s "$DIR/$FILE" "$DEST"
    fi
done


