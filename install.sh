#!/usr/bin/env bash

SCRIPT=$(basename "$0")
DIR=$PWD
cd "$DIR"

mkdir -p ~/.config/nvim

echo Creating links...
for FILE in *
do
    if [ "$FILE" = "$SCRIPT" ] || [ "$FILE" = "README.md" ]; then
        continue
    fi

    echo "-- $FILE"

    DEST="$HOME/.$FILE"

    if [ "$FILE" = "init.vim" ]; then
        DEST="$HOME/.config/nvim/$FILE"
    fi

    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        echo "$DEST exists."
    else
        ln -s "$DIR/$FILE" "$DEST"
    fi
done

MINPAC=~/.config/nvim/pack/minpac/opt/minpac
if [ ! -d "$MINPAC" ]; then
    echo "Getting minpac for neovim..."
    git clone https://github.com/k-takata/minpac.git $MINPAC
fi

B16="$HOME/.config/base16-shell"
if [ ! -d "$B16" ]; then
    echo "Getting base16-shell..."
    git clone https://github.com/chriskempson/base16-shell.git "$B16"
else
    echo "Updating base16-shell..."
    cd "$B16" && git pull
fi

FZ="$HOME/.fzf/"
if [ ! -d "$FZ" ]; then
    echo "Getting fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZ"
else
    echo "Updating fzf..."
    cd "$FZ" && git pull
fi
"$FZ"/install --all > /dev/null

PYEN="$HOME/.pyenv"
if [ ! -d "$PYEN" ]; then
    echo "Getting pyenv..."
    git clone https://github.com/pyenv/pyenv.git "$PYEN"
else
    echo "Updating pyenv..."
    cd "$PYEN" && git pull
fi

#TODO add git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
