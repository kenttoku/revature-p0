#!/bin/bash

## verify dev environment
source ~/.profile
brew=$(which brew)
node=$(which node)
git=$(which git)
az=$(which az)

## check for brew
if [ -z $brew ]; then
  echo "No brew. Please install before continuing" 1>&2
  exit 1
fi

## check for node
if [ -z $node ]; then
  echo "No node. Please install before continuing" 1>&2
  exit 2
fi

## check for git
if [ -z $git ]; then
  echo "No git. Please install before continuing" 1>&2
  exit 3
fi

## check for azure-cli
if [ -z $az ]; then
  echo "No azure-cli. Please install before continuing" 1>&2
  exit 4
fi