setopt noglobalrcs
skip_global_compinit=1

export REPORTTIME=30 # Show elapsed time if command took more than X seconds
export TIMEFMT='"%J"  %U user  %S system  %P cpu   %*E total'

export CFLAGS="-O2"

BREWDIR=/usr/local

if [[ -d /opt/homebrew ]]; then
  BREWDIR=/opt/homebrew
fi


PATH="$HOME/.local/bin:$HOME/bin:$BREWDIR/bin:$BREWDIR/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:$PATH"

# rust
PATH="$HOME/.cargo/bin:$PATH"

# go
export GOPATH=$HOME/.go
PATH="$HOME/.go/bin:$PATH"

# vim:set ft=zsh et sw=2:
