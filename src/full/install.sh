#!/bin/bash
set -euxo pipefail

VERSION="stable"
INSTALLDOTFILES=${INSTALLDOTFILES:-true}
DOTFILESREPOSITORY=${DOTFILESREPOSITORY:-}
DOTFILESFOLDER=${DOTFILESFOLDER:-nvim}

export VERSION INSTALLDOTFILES DOTFILESREPOSITORY DOTFILESFOLDER
$(dirname "$0")/../neovim/install.sh
$(dirname "$0")/../cli-oxided/install.sh
