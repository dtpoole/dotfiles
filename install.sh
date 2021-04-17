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
        echo "Getting pyenv-doctor..."
        git clone https://github.com/pyenv/pyenv-doctor.git "${PYEN}/plugins/pyenv-doctor"
        echo "Getting pyenv-update..."
        git clone https://github.com/pyenv/pyenv-update.git "${PYEN}/plugins/pyenv-update"
    else
        echo "Updating pyenv..."
        export PYENV_ROOT="$HOME/.pyenv"
        PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(command pyenv init -)"
        pyenv update
    fi
    echo
}

nvm() {
    echo ---- nvm ----
    NVMEN="$HOME/.nvm"
    if [ ! -d "$NVMEN" ]; then
        echo "Getting nvm..."
        git clone https://github.com/nvm-sh/nvm.git "$NVMEN"
        cd "$NVMEN"
    else
        echo "Updating nvm..."
        cd "$NVMEN"
        git fetch --tags origin
    fi
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    echo
}


rust() {
    echo ---- rust ----
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
    source "$HOME/.cargo/env"
    "$HOME/.cargo/bin/rustup" completions zsh cargo > ~/.zfunc/_cargo
    # "$HOME/.cargo/bin/cargo" install fd-find hyperfine ripgrep bat
    echo
}


keychain() {
    echo ---- keychain ----
    mkdir -p "$HOME/.local/bin"
    curl -so "$HOME/.local/bin/keychain" https://raw.githubusercontent.com/funtoo/keychain/master/keychain
    chmod 755 "$HOME/.local/bin/keychain"
    echo
}


symlinks
nvim
fzf
pyenv
#nvm
rust
keychain

echo DONE
