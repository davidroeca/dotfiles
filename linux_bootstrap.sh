#!/bin/bash

# Must be run as root
set -e

INSTALL_COMMAND="apt-get install -y"

# I would include git, but that needs to be run manually

apt-get update -y

# Install redshift
${INSTALL_COMMAND} gtk-redshift

# Install all useful text editing and document editing tools
${INSTALL_COMMAND} vim

# Basic command-line environment tools
${INSTALL_COMMAND} htop tree graphviz tmux


# Install python/development tools
${INSTALL_COMMAND} build-essential
${INSTALL_COMMAND} python-pip
${INSTALL_COMMAND} python-virtualenv
${INSTALL_COMMAND} python-dev
