#!/bin/bash

source ~/.commonrc

if show_host; then
    host="\[\033[0;32m\]\u@\h\[\033[00m\] "
fi

export PS1="${host}\[\033[34m\]\w\[\033[1;33m\]\$(git_status)\[\033[00m\] $ "

export TIMEFORMAT='%2lR real,  %3lU user,  %3lS system'

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
