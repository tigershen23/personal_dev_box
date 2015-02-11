#!/bin/sh

# Get my dotfiles
git clone https://github.com/tigershen23/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
