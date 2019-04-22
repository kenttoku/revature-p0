#!/bin/bash

## script automates the process of setting up a new virutal machine

## update apt
echo "updating apt"
apt update
apt upgrade -y
apt install -y build-essential curl file git
echo "apt update completed"

## set up brew - installation instructions from https://docs.brew.sh/Homebrew-on-Linux
# added -y flag to answer yes to confirmations

echo "brew install started"
echo "/n" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
echo "brew install complete"

## install tools
echo "tooling started"
brew install azure-cli gcc git node
echo "tooling complete"

## exit script
echo "installation complete"
exit 0