#!/bin/bash

export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";


if [ -n "${SSH_CLIENT}" ] && [ -z "${TMUX}" ]; then
    host="\[\033[0;32m\]\u@\h\[\033[00m\] "
fi

export PS1="${host}\[\033[34m\]\w\[\033[1;33m\]\[\033[00m\] $ "

export TIMEFORMAT='%2lR real,  %3lU user,  %3lS system'

# -- variables
export VISUAL=vim
( command -v nvim &> /dev/null; ) && export VISUAL=nvim
export EDITOR=$VISUAL
export GREP_COLOR='1;34'

export PAGER=less
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=5 --no-init --window=-4'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;34m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[37;100m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

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
alias llr='ll -t | head -10'
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
alias dtail="docker logs -tf --tail='30'"
alias ctop="docker run --rm -it --name=ctop \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    quay.io/vektorlab/ctop:latest"

# -- homebrew
if [[ -d "/usr/local/etc/bash_completion.d" ]]; then
    for completion_file in /usr/local/etc/bash_completion.d/*; do
        source "$completion_file"
    done
fi

# mac homebrew gnu tools
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# -- fzf
if (command -v fd &> /dev/null; ); then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=60%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --theme=base16 --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
"

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -f ~/.base16_theme ]] && source ~/.base16_theme

if command -v dircolors &> /dev/null; then
    eval "$(dircolors ~/.dir_colors)"
fi

