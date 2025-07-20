#!/bin/bash
set -euxo pipefail

USERNAME="${_REMOTE_USER:-vscode}"
HOME="/home/$USERNAME"

rm -rf $HOME/.rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | su - $USERNAME -c "sh -s -- -y"

su - $USERNAME -c "$HOME/.cargo/bin/cargo install xcp eza gitu bottom fd-find"
su - $USERNAME -c "$HOME/.cargo/bin/cargo install ripgrep --features pcre2"

chown -R $USERNAME:$USERNAME $HOME
