#!/bin/bash

# verify dev environment

## check for brew
brew=$(which brew)
node=$(which node)
git=$(which git)
az=$(which az)

echo $brew
echo $node
echo $git
echo $az