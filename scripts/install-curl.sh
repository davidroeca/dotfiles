#!/bin/bash

# Exit on any error
set -e

# Variables
CURL_VERSION="8.14.1"
CURL_URL="https://curl.se/download/curl-${CURL_VERSION}.tar.gz"
CURL_DIR="curl-${CURL_VERSION}"

# Save current directory
ORIGINAL_DIR=$(pwd)

echo "Changing to /tmp directory..."
cd /tmp

echo "Downloading curl ${CURL_VERSION}..."
wget "${CURL_URL}"

echo "Extracting archive..."
tar -xzf "curl-${CURL_VERSION}.tar.gz"

echo "Entering directory..."
cd "${CURL_DIR}"

echo "Configuring build..."
./configure --prefix="$HOME/.local" --with-openssl

echo "Building curl..."
make -j$(nproc)

echo "Installing curl..."
make install

echo "Cleaning up..."
cd /tmp
rm -rf "${CURL_DIR}" "curl-${CURL_VERSION}.tar.gz"

echo "Returning to original directory..."
cd "${ORIGINAL_DIR}"

echo "curl ${CURL_VERSION} has been successfully built and installed!"
echo "Location: $HOME/bin/bin/curl"
echo "Run 'curl --version' to verify the installation."
