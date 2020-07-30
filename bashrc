#!/bin/bash

if [ -n "${SSH_CLIENT}" ] && [ -z "${TMUX}" ]; then
    host="\[\033[0;32m\]\u@\h\[\033[00m\] "
fi

export PS1="${host}\[\033[34m\]\w\[\033[1;33m\]\[\033[00m\] $ "

export TIMEFORMAT='%2lR real,  %3lU user,  %3lS system'

# -- variables
export VISUAL=vim
( command -v dircolors &> /dev/null; ) && export VISUAL=nvim
export EDITOR=$VISUAL

# -- Aliases
alias ln='ln -v'
alias mkdir='mkdir -p'
alias ...='../..'
alias ls='ls --color=tty'
alias l='ls'
alias la='ls -lAh'
alias ll='ls -alh'
alias lh='ls -Alh'
alias lt='ls -lt'
alias e=\$EDITOR
alias v=\$VISUAL
alias vi=\$VISUAL
alias grep='grep --color=auto'
alias cls='clear'
alias h='history'
alias more='less'
alias j='jobs'
alias df='df -h'
alias du='du -h'
alias dc='docker-compose'

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -f ~/.base16_theme ]] && source ~/.base16_theme

if command -v dircolors &> /dev/null; then
    eval "$(dircolors ~/.dir_colors)"
fi
