#!/bin/bash

## script automates the process of setting up a new virutal machine

## update apt
sudo apt update
sudo apt upgrade -y

## set up brew - installation instructions from https://docs.brew.sh/Homebrew-on-Linux
# added -y flag to answer yes to confirmations
sudo apt-get install -y build-essential curl file git

# piping echo to answer prompt from brew installation
echo "/n" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
eval \$($(brew --prefix)/bin/brew shellenv)
brew --version

# ## install gcc
# brew install gcc

# ## install node
# brew install node

# ## install azure-cli
# brew install azure-cli