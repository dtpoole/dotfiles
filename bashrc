source ~/.commonrc

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        host="\[\033[0;32m\]\u@\h\[\033[00m\] "
fi

export PS1="${host}\[\033[34m\]\w\[\033[1;33m\]\$(parse_git_branch)\[\033[00m\] $ "

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
