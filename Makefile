DOT_CONFIG_DIRS_REL = $(wildcard dotfiles/.config/*)
DOT_CONFIG_DIRS_LINK = $(subst dotfiles, ~, $(DOT_CONFIG_DIRS_REL))

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# TODO: sysfiles firefox.pref for correct firefox beta installation
.PHONY: linux-bootstrap
linux-bootstrap: ## Installs a bunch of utilized system dependencies
	sudo apt update
	sudo apt install -y \
		xclip \
		xsel \
		git \
		neovim \
		zsh \
		stow \
		redshift-gtk \
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

.PHONY: dot_config
dot_config: $(DOT_CONFIG_DIRS_LINK)

~/.config/%: dotfiles/.config/%
	mkdir -p $@

.PHONY: link-dotfiles
link-dotfiles: dot_config ## links dotfiles to home directory via stow
	stow -t ~ -R dotfiles

.PHONY: unlink-dotfiles
unlink-dotfiles: dot_config ## removes stow-managed sym links
	stow -t ~ -D dotfiles

~/.zinit:
	git clone https://github.com/zdharma-continuum/zinit ~/.zinit

.PHONY: install-fonts
install-fonts:
	./scripts/install-fonts.sh

# Check that these versions are the latest that you want
.PHONY: init-envs
init-envs: ~/.zinit # sets up zinit
