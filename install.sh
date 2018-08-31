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

    if [ "$FILE" = "vimrc" ]; then
        ln -s "$DIR/$FILE" "$HOME/.config/nvim/init.vim"
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
    git clone https://github.com/pyenv/pyenv-virtualenv.git "${PYEN}/plugins/pyenv-virtualenv"
else
    echo "Updating pyenv..."
    cd "$PYEN" && git pull
    cd "${PYEN}/plugins/pyenv-virtualenv" && git pull
fi

NVMEN="$HOME/.nvm"
if [ ! -d "$NVMEN" ]; then
    echo "Getting nvm..."
    git clone https://github.com/creationix/nvm.git "$NVMEN"
else
    echo "Updating nvm..."
    cd "$NVMEN"
    git fetch --tags origin
fi
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
