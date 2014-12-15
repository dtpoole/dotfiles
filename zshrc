# modify the prompt to contain git branch name if applicable
git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null)
    if [[ -n $ref ]]; then
        echo " %{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}"
    fi
}

autoload -U colors && colors

setopt promptsubst
#export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) %# '
PROMPT='${SSH_CONNECTION+"%{$fg[green]%}%n@%m "}%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)%{$fg[green]%}%(1j. [%j].)%{$reset_color%} %# '

# ssh wrapper that rename current tmux window to the hostname of the
# remote host.
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
            eval host=\$$#
            tmux rename-window "$host"
            command ssh "$@"
            tmux set-window-option automatic-rename "on" 1>/dev/null
    else
            command ssh "$@"
    fi
}


# load our own completion functions
#fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# enable colored output from ls, etc
[[ -x dircolors ]] && eval "$(dircolors ~/.dir_colors)"

export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

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
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A"

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

REPORTTIME=10 # Show elapsed time if command took more than X seconds
TIMEFMT=$'%E real,\t%U user,\t%S sys'

PATH=/usr/local/bin:/usr/local/sbin:$PATH

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

if [[ -d "$HOME/bin" ]]; then
    PATH="$HOME/.bin:$PATH"
fi

## node
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

if [[ -d "$HOME/.npm/bin" ]]; then
    PATH=$HOME/.npm/bin:$PATH
fi


# ruby
if [[ -d "$HOME/.rvm" ]]; then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
fi

if which keychain &>/dev/null ; then
    eval `keychain -q --eval --quick --agents ssh --inherit any id_rsa`
fi



