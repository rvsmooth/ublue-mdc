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
  curl
  fastfetch
  firefox
  fish
  gcc-c++
  gwenview
  kde-connect
  libreoffice
  mozilla-ublock-origin
  neovim
  tmux
  wget
)

dnf5 install -y "${PACKAGES[@]}"

### Copy files to system
rsync -rvKl /ctx/system_files/ /

### Install starship
curl -L "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz" --retry 3 -o /tmp/starship.tar.gz
tar -xzf /tmp/starship.tar.gz -C /tmp
install -c -m 0755 /tmp/starship /usr/bin

## Add
echo 'eval "$(starship init bash)"' | sudo tee -a /etc/bashrc
echo 'eval "$(starship init zsh)"' | sudo tee -a /etc/zshrc
echo 'starship init fish | source' | sudo tee -a /etc/fish/config.fish

### Run scripts
/ctx/build_files/00-branding.sh
/ctx/build_files/01-nerdfonts.sh
