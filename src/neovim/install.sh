#!/bin/bash
set -euxo pipefail

USERNAME="${_REMOTE_USER:-vscode}"
HOME="/home/$USERNAME"
VERSION="stable"
INSTALL_DOTFILES=${INSTALL_DOTFILES:-true}
DOTFILES_REPOSITORY=${DOTFILES_REPOSITORY:-}
DOTFILES_FOLDER=${DOTFILES_FOLDER:-nvim}

echo "Install deps for neovim"
apt-get update \ 
  && apt-get install -y build-essential cmake gettext unzip curl python3-pip ninja-build \
  && apt-get -y clean && rm -rf /var/lib/apt/lists/*

echo "Downloading source for ${VERSION}..."
curl -sL https://github.com/neovim/neovim/archive/refs/tags/${VERSION}.tar.gz | tar -xzC /tmp 2>&1

cd /tmp/neovim-${VERSION}

make CMAKE_BUILD_TYPE=Release && make CMAKE_INSTALL_PREFIX=/usr/local/nvim install
ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim

rm -rf /tmp/neovim-${VERSION}

pip3 install -U pynvim

if [ "$INSTALL_DOTFILES" = "true" ]; then
  TEMP_DIR="$(mktemp -d)"
  git clone "$DOTFILES_REPOSITORY" "$TEMP_DIR"

  mkdir -p "$HOME/.config"

  cp -r "$TEMP_DIR/$DOTFILES_FOLDER" "$HOME/.config/nvim"

  rm -rf "$TEMP_DIR"

  chown -R $USERNAME:$USERNAME "$HOME/.config/nvim"
fi
