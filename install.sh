#!/usr/bin/env bash

SCRIPT=$(basename "$0")
DIR=$PWD
cd "$DIR"

mkdir -p ~/bin

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

nvim() {
    mkdir -p ~/.config/nvim
    NVIMCONF="$HOME/.config/nvim/init.vim"
    if [ ! -e "$NVIMCONF" ]; then
        ln -s "$DIR/vimrc" "$NVIMCONF"
    fi

    MINPAC=~/.config/nvim/pack/minpac/opt/minpac
    if [ ! -d "$MINPAC" ]; then
        echo "Getting minpac for neovim..."
        git clone https://github.com/k-takata/minpac.git $MINPAC
    fi

    MINPAC=~/.vim/pack/minpac/opt/minpac
    if [ ! -d "$MINPAC" ]; then
        echo "Getting minpac for vim..."
        git clone https://github.com/k-takata/minpac.git $MINPAC
    fi
    
}

base16() {
    B16="$HOME/.config/base16-shell"
    if [ ! -d "$B16" ]; then
        echo "Getting base16-shell..."
        git clone https://github.com/chriskempson/base16-shell.git "$B16"
    else
        echo "Updating base16-shell..."
        cd "$B16" && git pull
    fi
}

fzf() {
    FZ="$HOME/.fzf/"
    if [ ! -d "$FZ" ]; then
        echo "Getting fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git "$FZ"
    else
        echo "Updating fzf..."
        cd "$FZ" && git pull
    fi
    "$FZ"/install --all > /dev/null
}

pyenv() {
    PYEN="$HOME/.pyenv"
    if [ ! -d "$PYEN" ]; then
        echo "Getting pyenv..."
        git clone https://github.com/pyenv/pyenv.git "$PYEN"
        echo "Getting pyenv-virtualenv..."
        git clone https://github.com/pyenv/pyenv-virtualenv.git "${PYEN}/plugins/pyenv-virtualenv"
    else
        echo "Updating pyenv..."
        cd "$PYEN" && git pull
        echo "Updating pyenv-virtualenv..."
        cd "${PYEN}/plugins/pyenv-virtualenv" && git pull
    fi
}

nvm() {
    NVMEN="$HOME/.nvm"
    if [ ! -d "$NVMEN" ]; then
        echo "Getting nvm..."
        git clone https://github.com/creationix/nvm.git "$NVMEN"
        cd "$NVMEN"
    else
        echo "Updating nvm..."
        cd "$NVMEN"
        git fetch --tags origin
    fi
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
}

keychain() {
    echo "Installing keychain..."
    curl -o ~/bin/keychain https://raw.githubusercontent.com/funtoo/keychain/master/keychain
    chmod 755 ~/bin/keychain
}

nvim
base16
fzf
pyenv
nvm

read -p "Install/Update keychain (y/n)? " REPLY
[[ $REPLY =~ ^[Yy]$ ]] && keychain
