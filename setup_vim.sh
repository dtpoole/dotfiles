#!/bin/bash

if [ ! -d ~/.vim/bundle/vundle ]; then
    echo Setting up VIM...
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim +PluginInstall +qall
fi

