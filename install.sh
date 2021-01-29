#!/usr/bin/env bash

set -eu -o pipefail

SCRIPT=$(basename "$0")
DIR=$PWD
cd "$DIR" || exit


symlinks() {
    echo ---- Creating symlinks ----

    declare -a EXCLUDES=( "$SCRIPT" README.md Dockerfile run_docker.sh )

    for f in "$DIR"/*
    do
        FILE=${f##*/}

        EXCLUDE=false
        for X in "${EXCLUDES[@]}"; do
            if [ "$FILE" = "$X" ]; then
                EXCLUDE=true
                continue
            fi
        done

        if [ "$EXCLUDE" = true ]; then
            continue
        fi

        DEST="$HOME/.$FILE"

        echo "-- $FILE"
        if [ -f "$DEST" ] && [ ! -L "$DEST" ]; then
            mv "$DEST" "$DEST.$(date +%s)"
        fi

        if [ ! -L "$DEST" ]; then
            echo "$DEST -- Linking"
            ln -s "$DIR/$FILE" "$DEST"
        fi
    done
    echo
}

nvim() {
    echo ---- vim/nvim ----
    mkdir -p ~/.config/nvim ~/.vim
    NVIMCONF="$HOME/.config/nvim/init.vim"
    if [ ! -e "$NVIMCONF" ]; then
        ln -s "$DIR/vimrc" "$NVIMCONF"
    fi

    MINPAC=~/.config/nvim/pack/minpac/opt/minpac
    if [ ! -d "$MINPAC" ]; then
        echo "Getting minpac for vim/neovim..."
        git clone https://github.com/k-takata/minpac.git $MINPAC
        ln -s "$HOME/.config/nvim/pack" ~/.vim/pack
    fi

    echo
}

fzf() {
    echo ---- fzf ----
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
    echo ---- pyenv ----
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

rust() {
    echo ---- rust ----
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
    source "$HOME/.cargo/env"
    "$HOME/.cargo/bin/cargo" install fd-find hyperfine ripgrep bat
}


keychain() {
    echo ---- keychain ----
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
fzf
pyenv
#rust

if [[ $YES -eq 0 ]]; then
    read -rp "Install/Update keychain (y/n)? " REPLY
fi

if [[ $REPLY =~ ^[Yy]$ ]] || [ $YES -eq 1 ]; then
    keychain
fi

echo DONE
