#!/bin/bash

source ~/.commonrc

if command_exists brew; then
  for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
    source "$completion_file"
  done
fi

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        host="\[\033[0;32m\]\u@\h\[\033[00m\] "
fi

export PS1="${host}\[\033[34m\]\w\[\033[1;33m\]\$(git_prompt \$(git_branch))\[\033[00m\] $ "

export TIMEFORMAT='%2lR real,  %3lU user,  %3lS system'

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
