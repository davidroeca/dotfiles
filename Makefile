.PHONY: link_dotfiles
link_dotfiles:
	stow -t ~ dotfiles

.PHONY: link_anacron
link_anacron:
	stow -t ~ anacron

# TODO: Find a better way to achieve this; consider ansible
# TODO: Automate installation of vim-plug https://github.com/junegunn/vim-plug
#   * For vim
#   * For nvim
# TODO: Stow symlink to ~/.vimrc in ~/.config/nvim/init.vim
# TODO: Add vim8 ppa and installation automation
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
