.PHONY: link_dotfiles
link_dotfiles:
	stow -t ~ dotfiles

.PHONY: link_anacron
link_anacron:
	stow -t ~ anacron

~/.anacron:
	mkdir ~/.anacron

# Find a better way to achieve this; consider ansible
.PHONY:
linux_bootstrap:
	apt install \
		stow \
		gtk-redshift \
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
