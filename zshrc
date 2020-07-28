#zmodload zsh/zprof

# -- history
setopt share_history append_history hist_ignore_all_dups inc_append_history
setopt hist_verify
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# -- completion
setopt extendedglob
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -u -D
  touch ~/.zcompdump
else
  compinit -C
fi

zmodload -i zsh/complist
zstyle ':completion:*' menu select

# -- dirstack
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=10

# Allow [ or ] whereever you want
unsetopt nomatch


# -- variables
export VISUAL=vim
(( $+commands[nvim] )) && export VISUAL=nvim
export EDITOR=$VISUAL

#export GREP_COLOR='1;34'

#export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=5 --no-init --window=-4'
#export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
#export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
#export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
#export LESS_TERMCAP_so=$'\E[01;41;33m' # begin reverse video
#export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
#export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
#export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

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
alias e=$EDITOR
alias v=$VISUAL
alias vi=$VISUAL
alias grep='grep --color=auto'
alias cls='clear'
alias h='history'
alias more='less'
alias j='jobs'
alias df='df -h'
alias du='du -h'
alias dc='docker-compose'


# -- keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word


# -- prompt
setopt promptsubst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%F{yellow} '$'\U2387'' %b'

precmd() {
  vcs_info
}

if [ -n "${SSH_CLIENT}" ] && [ -z "${TMUX}" ]; then
  host="%n@%m "
fi

PROMPT='%F{green}$host%F{blue}%3~%b${vcs_info_msg_0_}%B%F{white} %#%b%F{white} '


# -- mac homebrew coreutils
if [[ -d "/usr/local/opt/coreutils/libexec/gnubin" ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

# -- golang
if [[ -d "$HOME/.go" ]]; then
  export GOPATH=$HOME/.go
  PATH="$HOME/.go/bin:$PATH"
fi

# -- python
pyenv() {
  if [[ -d "$HOME/.pyenv" ]]; then
    echo Loading pyenv...
    unset pyenv
    PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(command pyenv init -)"
    eval "$(command pyenv virtualenv-init -)"
    pyenv "$@"
  fi
}

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[[ -f ~/.base16_theme ]] && source ~/.base16_theme

# directory colors
if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[dircolors] )) && eval "$(dircolors -b ~/.dir_colors)"
fi

# remove dups from PATH
typeset -U PATH path

(( $+commands[keychain] )) && eval "$(keychain -q --eval --quick --ignore-missing --agents ssh --inherit any id_rsa id_ed25519)"

# vim:set ft=zsh et sw=2:
