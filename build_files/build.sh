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
  clang
  fastfetch
  firefox
  gcc-c++
  gwenview
  kde-connect
  libreoffice
  mozilla-ublock-origin
  neovim
  tmux
)

dnf5 install -y "${PACKAGES[@]}"

### Copy files to system
rsync -rvKl /ctx/system_files/ /

### Run scripts
/ctx/build_files/00-branding.sh
