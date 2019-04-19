#!/bin/bash

# script automates the process of setting up a new virutal machine

# update apt
sudo apt update
sudo apt upgrade -y

# set up brew
# installation instructions from https://docs.brew.sh/Homebrew-on-Linux
sudo apt-get install -y build-essential curl file git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

# install gcc
brew install gcc

#