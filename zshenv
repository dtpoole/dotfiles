setopt noglobalrcs

export REPORTTIME=30 # Show elapsed time if command took more than X seconds
export TIMEFMT=$'%E real,  %U user,  %S system'

PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

# rust
PATH="$HOME/.cargo/bin:$PATH"

# go
export GOPATH=$HOME/.go
PATH="$HOME/.go/bin:$PATH"

# vim:set ft=zsh et sw=2:
