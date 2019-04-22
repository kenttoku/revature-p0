#!/bin/bash

## equirement 2-
## automate the process of setting up a new git project repository structure
## include: verify req-1 is valid, create web node-based project (see week-3 revaturexyz.sh)
## name: git-node-project.sh

## verify dev environment
node=$(which node)
git=$(which git)

## check for node
if [ -z $node ]; then
  echo "No node. Please install before continuing" 1>&2
  exit 1
fi

## check for git
if [ -z $git ]; then
  echo "No git. Please install before continuing" 1>&2
  exit 1
fi

## create git project
dest=$1

if [ -z $dest ]; then
  echo "No directory specified. Please specify a directory" 1>&2
  exit 1
fi

echo $dest
mkdir -p $dest/git-project
cd $dest/git-project
git init

## make it a node project
npm init -y

## create all directories
mkdir -p \
  .docker \
  .github/ISSUE_TEMPLATE \
  .github/PULL_REQUEST_TEMPLATE \
  client \
  src \
  test

## create files in main directory
touch \
  .azureup.yaml \
  .dockerignore \
  .editorconfig \
  .gitignore \
  .markdownlint.yaml \
  CHANGELOG.md \
  LICENSE.txt \
  README.md

## create files in directories
### .docker
touch \
  .docker/dockerfile \
  .docker/dockerup.yaml

### .github
touch \
  .github/CODE-OF-CONDUCT.md \
  .github/CONTRIBUTING.md \
  .github/ISSUE_TEMPLATE/issue-template.md \
  .github/PULL_REQUEST_TEMPLATE/pull-request-template.md \

### others
touch \
  client/.gitkeep \
  src/.gitkeep \
  test/.gitkeep

## exit script
echo "project created in $dest"
exit 0