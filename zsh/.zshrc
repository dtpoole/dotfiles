#zmodload zsh/zprof

# -- history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# -- functions
fpath=(~/.zfunc $fpath)
autoload -Uz pyenv
autoload -Uz nvm
autoload -Uz ssh

# -- completion
setopt extendedglob
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -u
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
alias ll='ls -lh'
alias lt='ls -lt'
alias llr='ll -t | head -10'
alias e=$EDITOR
alias v=$VISUAL
alias vi=$VISUAL
alias grep='grep --color=auto'
alias cls='clear'
alias h='history -E'
alias more='less'
alias j='jobs'
alias df='df -h'
alias du='du -h'
alias dc='docker-compose'
alias dtail="docker logs -tf --tail='30'"

if [[ "$OSTYPE" == "linux-gnu"* ]] && (($+commands[fdfind])); then
  alias -g fd=fdfind
fi

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

if ([ -n "${SSH_CLIENT}" ] || [ -f /.dockerenv ] ) && [ -z "${TMUX}" ]; then
  host="%n@%m "
fi

PROMPT='%F{green}$host%F{blue}%3~%b${vcs_info_msg_0_}%B%F{white} %#%b%F{white} '

# -- homebrew gnu tools
if (( $+commands[brew] )); then
  PATH="$BREWDIR/opt/coreutils/libexec/gnubin:$PATH"
fi

# -- fzf
if (( $+commands[fd] || $+commands[fdfind] )); then
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
bindkey -s '^e' 'vi $(fzf)\n'

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[vivid] )) && export LS_COLORS="$(vivid generate ~/.config/vivid/themes/nord.yml)"
fi

# remove dups from PATH
typeset -U PATH path
export PATH=$PATH

# vim:set ft=zsh et sw=2:
