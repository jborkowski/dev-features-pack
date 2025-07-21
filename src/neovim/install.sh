#!/bin/bash
set -euxo pipefail

USERNAME="${_REMOTE_USER:-vscode}"
HOME="/home/$USERNAME"
VERSION="stable"
INSTALLDOTFILES=${INSTALLDOTFILES:-false}
DOTFILESREPOSITORY=${DOTFILESREPOSITORY:-}
DOTFILESFOLDER=${DOTFILESFOLDER:-nvim}

echo "Install deps for neovim"

apt-get update
apt-get install -y build-essential cmake gettext unzip curl python3-pip ninja-build python3-pynvim
apt-get -y clean && rm -rf /var/lib/apt/lists/*

echo "Downloading source for ${VERSION}..."
curl -sL https://github.com/neovim/neovim/archive/refs/tags/${VERSION}.tar.gz | tar -xzC /tmp 2>&1

cd /tmp/neovim-${VERSION}

make CMAKE_BUILD_TYPE=Release && make CMAKE_INSTALL_PREFIX=/usr/local/nvim install
ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim

rm -rf /tmp/neovim-${VERSION}

if [ "$INSTALLDOTFILES" = "true" ]; then
  TEMP_DIR=$(mktemp -d /tmp/dotfiles.XXXXXX)
  git clone "$DOTFILESREPOSITORY" "$TEMP_DIR"

  mkdir -p "$HOME/.config"

  cp -r "$TEMP_DIR/$DOTFILESFOLDER" "$HOME/.config/nvim"

  rm -rf "$TEMP_DIR"

  chown -R $USERNAME:$USERNAME "$HOME/.config/nvim"
fi
