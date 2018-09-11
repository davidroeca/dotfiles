.PHONY: link_dotfiles
link_dotfiles:
	stow -t ~ dotfiles

.PHONY: link_anacron
link_anacron:
	stow -t ~ anacron

# Find a better way to achieve this; consider ansible
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
