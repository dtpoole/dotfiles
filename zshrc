source ~/.commonrc

autoload -U colors && colors

# completion
autoload -U compinit
compinit -u

zmodload -i zsh/complist
zstyle ':completion:*' menu select

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

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

export REPORTTIME=10 # Show elapsed time if command took more than X seconds
export TIMEFMT=$'%E real,  %U user,  %S system'

if show_host; then
    host="%{$fg[green]%}%n@%m "
fi

PROMPT='$host%{$fg[blue]%}%~%{$reset_color%}%{$fg_bold[yellow]%}$(git_status)%{$reset_color%}%{$fg[green]%}%(1j. [%j].)%{$reset_color%} %# '

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
