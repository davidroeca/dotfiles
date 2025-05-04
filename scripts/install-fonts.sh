#!/bin/bash

# Inspired by https://dev.to/pulkitsingh/install-nerd-fonts-or-any-fonts-easily-in-linux-2e3l

set -euo pipefail

URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Mononoki.zip"

TEMP_DIR=$(mktemp -d)

wget -O "$TEMP_DIR/font.zip" "$URL"

unzip "$TEMP_DIR/font.zip" -d "$TEMP_DIR"

# Improvement where if ttf or otf don't have any files, the script can still
# continue
shopt -s nullglob
sudo mv "$TEMP_DIR"/*.{ttf,otf} /usr/local/share/fonts/
# unset nullglob
shopt -u nullglob

fc-cache -f -v

rm -rf "$TEMP_DIR"
