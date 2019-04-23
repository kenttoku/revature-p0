#!/bin/bash
## automate the process of setting up a new git project repository structure

##### VARIABLES #####
directory=$1
user_email=$2
user_name=$3

## verify dev environment
node=$(which node)
git=$(which git)

echo "Verifying environment"
## check for node
if [ -z "$node" ]; then
  echo "No node. Please install before continuing." 1>&2
  exit 1
fi

## check for git
if [ -z "$git" ]; then
  echo "No git. Please install before continuing." 1>&2
  exit 1
fi

echo "Completed environment verification"

## create file structure

## validate input. Directory must be specified
if [ -z "$directory" ]; then
  echo "No directory specified. Please specify a directory." 1>&2
  exit 1
fi

if [ -z "$user_email" ]; then
  echo "No email specified. Please specify a email." 1>&2
  exit 1
fi

if [ -z "$user_name" ]; then
  echo "No name specified. Please specify a name." 1>&2
  exit 1
fi

## Validate directory. It must be empty or nonexistent
if [ -d $directory ] && [ -n "$(ls -A ${directory})" ]; then
  echo "Directory is not empty. Please choose another location or empty the directory." 1>&2
  exit 1
fi

echo "Creating file structure"

mkdir -p $directory
cd $directory

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

echo "File structure created"

## Convert to git repo
echo "Initializing git"
git config user.email "$user_email"
git config user.name "$user_name"
git init

## Convert to Node project
echo "Creating Node Project"
npm init -y

## exit script
echo "project created in $(pwd)"