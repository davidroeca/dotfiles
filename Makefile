DOT_CONFIG_DIRS_REL = $(wildcard dotfiles/.config/*)
DOT_CONFIG_DIRS_LINK = $(subst dotfiles, ~, $(DOT_CONFIG_DIRS_REL))

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# TODO: sysfiles firefox.pref for correct firefox beta installation
.PHONY: linux-bootstrap
linux-bootstrap: ## Installs a bunch of utilized system dependencies
	sudo add-apt-repository -y ppa:aslatter/ppa # alacritty
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

~/.zinit:
	git clone https://github.com/zdharma-continuum/zinit ~/.zinit

# Check that these versions are the latest that you want
.PHONY: init-envs
init-envs: ~/.zinit # sets up zinit

.PHONY: pipx-install
pipx-install:
	pip install -U pipx

.PHONY: python-packages
python-packages: pipx-install
	zsh -i -c pythonglobal-install

.PHONY: node-packages
node-packages: SHELL:=/bin/zsh
node-packages: ## installs node packages that are leveraged often
	zsh -i -c nodeglobal-install

.PHONY: neovim-pluginstall
neovim-pluginstall: ## installs neovim plugins in headless mode
	nvim --headless +UpdateAll +qa!

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
