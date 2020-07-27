source ~/.commonrc

setopt extendedglob

# completion
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -u -D
    touch ~/.zcompdump
else
    compinit -C
fi

zmodload -i zsh/complist
zstyle ':completion:*' menu select

# history settings
setopt share_history append_history hist_ignore_all_dups inc_append_history
setopt hist_verify
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A"

setopt promptsubst

export REPORTTIME=30 # Show elapsed time if command took more than X seconds
export TIMEFMT=$'%E real,  %U user,  %S system'

if show_host; then
    host="%F{green}%n@%m "
fi

PROMPT='$host%F{blue}%3~%B%F{yellow}$(git_status)%B%F{white} %#%b%F{white} '


[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# remove dups from PATH
typeset -U path

_colorz
