#!/bin/bash
# automate the process of starting, stopping a node web application

## Functions
## Start node project
start()
{
  # check package.json for  "start" script
  startscript=$(cat package.json | grep "start")

  if [ -z "$startscript" ]; then
    echo "package.json does not contain 'start' script." 1>&2
    exit 1
  fi

  # start project
  npm start
}

## Stop node project
stop()
{
  # check package.json for "stop" script
  stopscript=$(cat package.json | grep "stop")

  if [ -z "$stopscript" ]; then
    echo "package.json does not contain 'stop' script." 1>&2
    exit 1
  fi

  # stop project
  npm stop
}

## Variables
command=$1
directory=$2

## check for node
node=$(which node)

if [ -z "$node" ]; then
  echo "No node. Please install before continuing." 1>&2
  exit 1
fi

# validate command
if [ -z "$command" ]; then
  echo "Missing command. Please use 'start' or 'stop'" 1>&2
  exit 1
fi

# validate directory
if [ -z "$directory" ]; then
  echo "Missing directory" 1>&2
  exit 1
fi

if ! [ -d $directory ]; then
  echo "Invalid directory" 1>&2
  exit 1
fi

# change to directory
cd $directory

# check directory for package.json
if ! [ -e package.json ]; then
  echo "Directory does not contain package.json" 1>&2
  exit 1
fi

# validate command
case "$command" in
  "start")
    start
  ;;
  "stop")
    stop
  ;;
  *)
    echo "Invalid command. Please use 'start' or 'stop'" 1>&2
    exit 1
  ;;
esac