FZHOME := $(HOME)/.fzf

PYENV := $(HOME)/.pyenv
PYENV_PLUGINS := pyenv-virtualenv pyenv-doctor pyenv-update

VIM_NVIMCONF := $(HOME)/.config/nvim

KEYCHAIN := $(HOME)/.local/bin/keychain


all: init fzf


init:
	@echo ---- env ----
	mkdir -p $(HOME)/.local/bin
	touch $(HOME)/.hushlogin
	stow -D */
	stow */

fzf:
	@echo ---- fzf ----
	test -d $(FZHOME) || git clone --depth 1 https://github.com/junegunn/fzf.git $(FZHOME)
	test -d $(FZHOME) && cd $(FZHOME) && git pull --rebase
	$(FZHOME)/install --all > /dev/null


pyenv: pyenv-base pyenv-plugins pyenv-updater

pyenv-base:
	@echo ---- pyenv ----
	test -d $(PYENV) || git clone https://github.com/pyenv/pyenv.git $(PYENV)

pyenv-plugins: | $(PYENV_PLUGINS)

${PYENV_PLUGINS}:
	@echo ---- pyenv plugin: ${@} ----
	test -d $(PYENV)/plugins/$@ || git clone https://github.com/pyenv/$@.git $(PYENV)/plugins/$@

pyenv-updater:
	PYENV_ROOT="$(PYENV)" && $(PYENV)/bin/pyenv update


rust:
	@echo ---- rust ----
	curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
	$(HOME)/.cargo/bin/rustup completions zsh cargo > $(HOME)/.zfunc/_cargo
#	$(HOME)/.cargo/bin/cargo install fd-find hyperfine ripgrep bat


keychain:
	@echo ---- keychain ----
	curl -so $(KEYCHAIN) https://raw.githubusercontent.com/funtoo/keychain/master/keychain && chmod 755 $(KEYCHAIN)
