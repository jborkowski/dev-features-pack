#!/bin/bash
set -euxo pipefail

VERSION="stable"
INSTALL_DOTFILES=${INSTALL_DOTFILES:-true}
DOTFILES_REPOSITORY=${DOTFILES_REPOSITORY:-}
DOTFILES_FOLDER=${DOTFILES_FOLDER:-nvim}

export VERSION INSTALL_DOTFILES DOTFILES_REPOSITORY DOTFILES_FOLDER
$(dirname "$0")/../neovim/install.sh
$(dirname "$0")/../cli-oxided/install.sh
