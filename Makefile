DOT_CONFIG_DIRS_REL = $(wildcard dotfiles/.config/*)
DOT_CONFIG_DIRS_LINK = $(subst dotfiles, ~, $(DOT_CONFIG_DIRS_REL))
NODE_VERSION = 12.10.0
PYTHON_VERSION = 3.7.4
YARN_VERSION = 1.9.4

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# TODO: sysfiles firefox.pref for correct firefox beta installation
.PHONY: linux-bootstrap
linux-bootstrap: ## Installs a bunch of utilized system dependencies
	sudo add-apt-repository -y ppa:neovim-ppa/unstable
	sudo add-apt-repository -y ppa:mmstick76/alacritty
	sudo add-apt-repository -y ppa:mozillateam/firefox-next
	sudo apt update
	sudo apt install -y \
		xclip \
		xsel \
		git \
		neovim \
		zsh \
		stow \
		gtk-redshift \
		htop \
		tree \
		graphviz \
		tmux \
		alacritty \
		build-essential \
		python3-dev \
		python3-venv \
		libffi-dev \
		libssl-dev \
		libbz2-dev \
		libreadline-dev \
		libsqlite3-dev \
		wget \
		tk-dev \
		xz-utils \
		llvm \
		libncurses5-dev \
		libncursesw5-dev \
		liblzma-dev \
		zlib1g-dev \
		snapd \
		automake \
		autoconf \
		libreadline-dev \
		libncurses-dev \
		libssl-dev \
		libyaml-dev \
		libxslt-dev \
		libffi-dev \
		libtool \
		unixodbc-dev \
		unzip \
		curl
	snap install chromium spotify
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: dot_config
dot_config: $(DOT_CONFIG_DIRS_LINK)

~/.config/%: dotfiles/.config/%
	mkdir -p $@

.PHONY: remove-existing-dotfiles
remove-existing-dotfiles: ## Removes dotfiles from original mint env
	rm ~/.bashrc
	rm ~/.profile

.PHONY: link-dotfiles
link-dotfiles: dot_config ## links dotfiles to home directory via stow
	stow -t ~ -R dotfiles

.PHONY: unlink-dotfiles
unlink-dotfiles: dot_config ## removes stow-managed sym links
	stow -t ~ -D dotfiles


# Used because asdf.sh uses bash
~/.asdf: SHELL:=/bin/bash
# used because `cd` requires one shell
.ONESHELL:
~/.asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	cd ~/.asdf
	git checkout $(shell git describe --abbrev=0 --tags)
	cd -
	source ~/.asdf/asdf.sh
	asdf plugin-add python
	asdf plugin-add nodejs
	asdf plugin-add yarn
	asdf install python $(PYTHON_VERSION)
	asdf global python $(PYTHON_VERSION) system
	asdf install nodejs $(NODE_VERSION)
	bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
	asdf global nodejs $(NODE_VERSION)
	asdf install yarn $(YARN_VERSION)
	asdf global yarn $(YARN_VERSION)

~/.zplug:
	git clone https://github.com/zplug/zplug ~/.zplug

# Check that these versions are the latest that you want
.PHONY: init-envs
init-envs: ~/.asdf ~/.zplug # sets up asdf and zplug

.PHONY: python-packages
python-packages: ## installs python packages that are leveraged often
	pip install \
		pynvim \
		grip

.PHONY: node-packages
node-packages: ## installs node packages that are leveraged often
	npm install -g \
		create-react-app

.PHONY: neovim-pluginstall
neovim-pluginstall: ## installs neovim plugins in headless mode
	nvim --headless +PlugInstall +qa!

.PHONY: rust-dependencies
rust-dependencies: ## Installs rust dependencies--requires rustup
	rustup toolchain add nightly
	rustup component add rust-src
	cargo install \
		racer \
		ripgrep

.PHONY: setup-all
setup-all: linux-bootstrap remove-existing-dotfiles link-dotfiles init-envs python-packages node-packages neovim-pluginstall ## sets up entire system
	echo "switching default shell to $(shell which zsh)"
	sudo chsh -s $(shell which zsh) $(USER)
	echo "Make sure to manually install rustup (todo...)"
	echo "Make sure to manually install rust language server;"
	echo "> rustup component add rls rust-analysis rust-src"
	echo "Make sure to manually install racer with cargo"
	echo "> cargo install racer"
	echo "Make sure to manually install poetry (todo...)"
	echo "Now switch your default terminal to 'alacritty' and open a new terminal"
