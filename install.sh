#!/usr/bin/env bash

set -eu -o pipefail

SCRIPT=$(basename "$0")
DIR=$PWD
cd "$DIR" || exit


symlinks() {
    echo ---- Creating symlinks...

    for f in "$DIR"/*
    do
        FILE=${f##*/}

        if [ "$FILE" = "$SCRIPT" ] || [ "$FILE" = "README.md" ] || [ "$FILE" = "Dockerfile" ] || [ "$FILE" = "run_docker.sh" ]; then
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
    echo
}

nvim() {
    echo ---- vim/nvim
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
    echo
}

base16() {
    echo ---- base16-shell
    B16="$HOME/.config/base16-shell"
    if [ ! -d "$B16" ]; then
        echo "Getting base16-shell..."
        git clone https://github.com/chriskempson/base16-shell.git "$B16"
    else
        echo "Updating base16-shell..."
        cd "$B16" && git pull --rebase
    fi
    echo
}

fzf() {
    echo ---- fzf
    FZ="$HOME/.fzf/"
    if [ ! -d "$FZ" ]; then
        echo "Getting fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git "$FZ"
    else
        echo "Updating fzf..."
        cd "$FZ" && git pull --rebase
    fi
    "$FZ"/install --all > /dev/null
    echo
}

pyenv() {
    echo ---- pyenv
    PYEN="$HOME/.pyenv"
    if [ ! -d "$PYEN" ]; then
        echo "Getting pyenv..."
        git clone https://github.com/pyenv/pyenv.git "$PYEN"
        echo "Getting pyenv-virtualenv..."
        git clone https://github.com/pyenv/pyenv-virtualenv.git "${PYEN}/plugins/pyenv-virtualenv"
    else
        echo "Updating pyenv..."
        cd "$PYEN" && git pull --rebase
        echo "Updating pyenv-virtualenv..."
        cd "${PYEN}/plugins/pyenv-virtualenv" && git pull --rebase
    fi
    echo
}

keychain() {
    echo "---- keychain"
    mkdir -p "$HOME/bin"
    curl -so ~/bin/keychain https://raw.githubusercontent.com/funtoo/keychain/master/keychain
    chmod 755 ~/bin/keychain
}


YES=0
REPLY=0

if [ $# -eq 1 ]; then
    if [ "$1" == "-y" ]; then
        YES=1
    fi
fi

symlinks
nvim
#base16
fzf
pyenv

if [[ $YES -eq 0 ]]; then
    read -rp "Install/Update keychain (y/n)? " REPLY
fi

if [[ $REPLY =~ ^[Yy]$ ]] || [ $YES -eq 1 ]; then
    keychain
fi
