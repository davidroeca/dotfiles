#!/bin/bash

# Must be run as root 
set -e

INSTALL_COMMAND="apt-get install -y"

# I would include git, but that needs to be run manually

# Basic command-line environment tools
${INSTALL_COMMAND} htop tree graphviz
${INSTALL_COMMAND} tmux terminator

# Install all useful text editing and document editing tools
${INSTALL_COMMAND} vim sublime-text
add-apt-repository ppa:webupd8team/atom -y
apt-get update -y
${INSTALL_COMMAND} atom

# Install python/development tools
${INSTALL_COMMAND} build-essential
${INSTALL_COMMAND} python-pip
${INSTALL_COMMAND} python-virtualenv
${INSTALL_COMMAND} python-dev
pip install awscli

# Vim setup
VUNDLE_REPO="https://github.com/VundleVim/Vundle.vim.git"
VUNDLE_PATH="${HOME}/.vim/bundle/Vundle.vim"
echo $VUNDLE_PATH

if [ -d ${VUNDLE_PATH} ]
then
    echo "Vundle is already installed"
else
    echo "Cloning Vundle into the appropriate location"
    git clone ${VUNDLE_REPO} ${VUNDLE_PATH}
fi
