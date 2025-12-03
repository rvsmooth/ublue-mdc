#!/bin/bash

set -ouex pipefail

### Install packages
# Install VSCode
dnf5 config-manager addrepo --set=baseurl="https://packages.microsoft.com/yumrepos/vscode" --id="vscode"
dnf5 config-manager setopt vscode.enabled=0
dnf5 config-manager setopt vscode.gpgcheck=0
dnf5 install --nogpgcheck --enable-repo="vscode" -y \
  code

# Install other packages
PACKAGES=(
  cargo
  clang
  fastfetch
  firefox
  gcc-c++
  gwenview
  kde-connect
  libreoffice
  mozilla-ublock-origin
  neovim
  rust
  rustup
  tmux
)

dnf5 install -y "${PACKAGES[@]}"

#### Example for enabling a System Unit File
systemctl enable podman.socket
