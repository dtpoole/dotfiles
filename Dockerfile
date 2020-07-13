FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y locales git zsh tree vim-nox ripgrep tmux curl wget \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

WORKDIR /root
COPY . .dotfiles

ENV TZ=UTC
ENV TERM=xterm-256color
ENV SHELL=/bin/zsh

RUN rm .bashrc && cd .dotfiles && ./install.sh -y
ENTRYPOINT [ "zsh", "-l" ]
