#!/usr/bin/env bash

SCRIPT=$(basename "$0")
DIR=$PWD
cd "$DIR"


if [ ! -d "$HOME/.config/base16-shell" ]; then
    echo "Getting base16-shell..."
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi


echo Creating links...
for FILE in *
do
    if [ "$FILE" = "$SCRIPT" ] || [ "$FILE" = "README.md" ]; then
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


