DOT_CONFIG_DIRS_REL = $(wildcard dotfiles/.config/*)
DOT_CONFIG_DIRS_LINK = $(subst dotfiles, ~, $(DOT_CONFIG_DIRS_REL))

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: linux-bootstrap
linux-bootstrap: ## Installs a bunch of utilized system dependencies
	add-apt-repository ppa:neovim-ppa/unstable && \
	apt install \
		git \
		curl \
		nvim \
		stow \
		gtk-redshift \
		htop \
		tree \
		graphviz \
		tmux \
		build-essential \
		python3-dev \
		python3-venv
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: dot_config
dot_config: $(DOT_CONFIG_DIRS_LINK)

~/.config/%: dotfiles/.config/%
	mkdir -p $@

.PHONY: link-dotfiles
link-dotfiles: dot_config # links dotfiles to home directory via stow
	stow -t ~ -R dotfiles

.PHONY: unlink-dotfiles
unlink-dotfiles: dot_config ## removes stow-managed sym links
	stow -t ~ -D dotfiles

~/.nodenv:
	git clone https://github.com/nodenv/nodenv
	git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build

~/.pyenv:
	git clone https://github.com/pyenv/pyenv ~/.pyenv

# Check that these versions are the latest that you want
.PHONY: init-envs
init-envs: ~/.nodenv ~/.pyenv # sets up nodenv and pyenv
	~/.nodenv/bin/nodenv install 12.7.0
	~/.nodenv/bin/nodenv global 12.7.0
	~/.pyenv/bin/pyenv install 3.7.4
	~/.pyenv/bin/pyenv global 3.7.4 system

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

.PHONY: full-setup
full-setup: linux-bootstrap link-dotfiles init-envs python-packages node-packages neovim-pluginstall ## sets up entire system
	echo "Make sure to manually install rustup (todo...)"
	echo "Make sure to manually install racer with cargo `cargo install racer` (todo...)"
	echo "Make sure to manually install poetry (todo...)"
