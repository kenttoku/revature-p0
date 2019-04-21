#!/bin/bash
# automate the process of starting, stopping a node web application

start()
{
  dirpath=$1

  # validate input
  if [ -z $dirpath ]; then
    echo "Missing directory name"
    exit 1
  elif ! [ -d $dirpath ]; then
    echo "Invalid directory"
    exit 1
  elif ! [ -d $dirpath/package.json ]; then
    echo "Invalid node project. Please make sure there is a package.json in the directory"
    exit 1
  elif ! [ -d $(cat $dirpath/package.json | grep -E "start" ]; then
    echo "No start script"
    exit 1
  fi

  echo "starting app"
  cd $dirpath
  npm start
}

stop()
{
  echo "stopping app"
}

command=$1

if [ -z $command ]; then
  echo "Missing command. Please use 'start' or 'stop'"
  exit 1
fi

if [ $command = "start" ]; then
  dirpath=$2
  start $dirpath
elif [ $command = "stop" ]; then
  stop
else
  echo "Invalid command. Please use 'start' or 'stop'"
fi

exit 0