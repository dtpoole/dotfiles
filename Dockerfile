FROM alpine:3.12

# Static GID/UID is also useful for chown'ing files outside the container where
# such a user does not exist.
RUN addgroup -g 10001 -S nonroot && adduser -u 10000 -S -s /bin/zsh -G nonroot -h /home/nonroot nonroot

# tools
RUN apk add --no-cache bind-tools git bash zsh zsh-vcs tmux neovim openssh tree vim wget curl fd ripgrep perl sqlite

# build python
RUN apk add --no-cache build-base libffi-dev openssl-dev bzip2-dev zlib-dev readline-dev sqlite-dev

RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--", "zsh"]

WORKDIR /home/nonroot
COPY . .dotfiles
RUN chown -R nonroot:nonroot .dotfiles 

USER nonroot
RUN echo export CONTAINER=1 > .zshrc.local
RUN cd .dotfiles && ./install.sh -y

ENV TZ=UTC
ENV TERM=xterm-256color
ENV SHELL=/bin/zsh

CMD ["-l"]
