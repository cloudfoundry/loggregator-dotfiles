#!/bin/bash

set -e # exit on first failure

function link {
    ln -s $PWD/$1 $HOME/.$1
}

for dotfile in bashrc zshrc profile tmux.conf vimrc vim; do
    echo Linking $dotfile...
    link $dotfile
done;

echo Done
