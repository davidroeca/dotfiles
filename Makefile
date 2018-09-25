DOT_CONFIG_DIRS_REL = $(wildcard dotfiles/.config/*)
DOT_CONFIG_DIRS_LINK = $(subst dotfiles, ~, $(DOT_CONFIG_DIRS_REL))

.PHONY: dot_config
dot_config: $(DOT_CONFIG_DIRS_LINK)

~/.config/%: dotfiles/.config/%
	mkdir -p $@

.PHONY: link_dotfiles
link_dotfiles: dot_config
	stow -t ~ -R dotfiles

.PHONY: link_anacron
link_anacron:
	stow -t ~ -R anacron

# TODO: Find a better way to achieve this; consider ansible
# TODO: Automate installation of vim-plug https://github.com/junegunn/vim-plug
#   * For vim
#   * For nvim
# TODO: Add vim8 ppa and installation automation
# TODO: Handle installation of tern `npm install -g tern`
# TODO: Handle installation of racer `cargo install racer`
.PHONY: linux_bootstrap
linux_bootstrap:
	add-apt-repository ppa:neovim-ppa/unstable && \
	apt install \
		stow \
		gtk-redshift \
		nvim \
		vim \
		htop \
		tree \
		graphviz \
		tmux \
		build-essential \
		python-pip \
		python-virtualenv \
		xdg-open \
		python-dev
