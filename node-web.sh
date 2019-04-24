#!/bin/bash
# automate the process of starting, stopping a node web application

## Functions
## Start node project
start()
{
  ## check package.json for  "start" script
  startscript=$(cat package.json | grep "start")

  if [ -z "$startscript" ]; then
    echo "package.json does not contain 'start' script." 1>&2
    exit 1
  fi

  ## start project
  echo "Validation complete. Attempting to start project"
  npm start
}

## Stop node project
stop()
{
  ## check package.json for "stop" script
  stopscript=$(cat package.json | grep "stop")

  if [ -z "$stopscript" ]; then
    echo "package.json does not contain 'stop' script." 1>&2
    exit 1
  fi

  ## stop project
  echo "Validation complete. Attempting to stop project"
  npm stop
}

## Main
## Variables
command=$1
directory=$2

## check for node
if [ -z $(which node) ]; then
  echo "No node. Please install before continuing." 1>&2
  exit 1
fi

## validate command
if [ -z "$command" ]; then
  echo "Missing command. Please use 'start' or 'stop'" 1>&2
  exit 1
fi

if [ "$command" != "start" ] && [ "$command" != "stop" ]; then
  echo "Invalid command. Please use 'start' or 'stop'" 1>&2
  exit 1
fi

## validate directory
if [ -z "$directory" ]; then
  echo "Missing directory" 1>&2
  exit 1
fi

if ! [ -d $directory ]; then
  echo "Invalid directory" 1>&2
  exit 1
fi

## change to directory
cd $directory

## check directory for package.json
if ! [ -e package.json ]; then
  echo "Directory does not contain package.json" 1>&2
  exit 1
fi

## validate and run command
case "$command" in
  "start") start;;
  "stop") stop;;
esac