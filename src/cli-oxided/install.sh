#!/bin/bash
set -euxo pipefail

USERNAME="${_REMOTE_USER:-vscode}"
HOME="/home/$USERNAME"

rm -rf $HOME/.rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | su - $USERNAME -c "sh -s -- -y"

su - $USERNAME -c "$HOME/.cargo/bin/cargo install xcp eza gitu bottom ripgrep --features pcre2 fd-find"

chown -R $USERNAME:$USERNAME $HOME
