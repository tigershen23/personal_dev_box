#!/bin/sh

# Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Get my dotfiles
git clone https://github.com/tigershen23/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
