#!/bin/bash

set -ex

sudo apt update
sudo apt install -y automake build-essential pkg-config libncurses5-dev \
  libevent-dev vim git ruby cmake libfreetype6-dev libfontconfig1-dev xclip curl \
  chromium-browser python python-gtk2 python-xlib python-dbus python-wnck python-setuptools \
  htop python-pip openssh-server virtualbox-qt


curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

if [ ! -d ~/workspace ]; then
    mkdir ~/workspace
fi

pushd ~/workspace
  # Install alacritty
  git clone https://github.com/jwilm/alacritty.git
  pushd alacritty
    cargo build --release
    sudo cp target/release/alacritty /usr/local/bin
    cp Alacritty.desktop ~/.local/share/applications
  popd
  rm -rf alacritty

  # Install tmux
  wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
  tar xzvf tmux-2.6.tar.gz
  pushd tmux-2.6
    ./configure
    make
    sudo make install
  popd
  rm tmux-2.6.tar.gz
  rm -rf tmux-2.6

  # Install chruby
  wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
  tar -xzvf chruby-0.3.9.tar.gz
  pushd chruby-0.3.9/
    sudo make install
  popd
  rm chruby-0.3.9.tar.gz
  rm -rf chruby-0.3.9

  wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz
  tar -xzvf ruby-install-0.6.1.tar.gz
  pushd ruby-install-0.6.1/
    sudo make install
  popd
  rm ruby-install-0.6.1.tar.gz
  rm -rf ruby-install-0.6.1

  # Install Go
  wget https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz
  tar xzvf go1.9.4.linux-amd64.tar.gz
  sudo mv go /usr/local/go
  rm go1.9.4.linux-amd64.tar.gz

  # Install dotfiles
  git clone https://github.com/cloudfoundry/loggregator-dotfiles.git
  pushd loggregator-dotfiles
    ./install.sh
  popd

  # Install VeraCrypt
  wget https://launchpad.net/veracrypt/trunk/1.21/+download/veracrypt-1.21-setup.tar.bz2
  mkdir veracrypt-setup
  tar xvfj veracrypt-1.21-setup.tar.bz2 -C veracrypt-setup/
  pushd veracrypt-setup
    ./veracrypt-1.21-setup-gui-x64
  popd
  rm veracrypt-1.21-setup.tar.bz2
  rm -rf veracrypt-setup

  # Install quicktile
  sudo pip install https://github.com/ssokolow/quicktile/archive/master.zip

  # Install git-duet
  mkdir git-duet
  pushd git-duet
    wget https://github.com/git-duet/git-duet/releases/download/0.5.2/linux_amd64.tar.gz
    tar xzvf linux_amd64.tar.gz
    cp git-* ~/bin/.
  popd
popd
