#!/bin/bash
# automate the process of starting, stopping a node web application

start()
{
  filepath=$1

  # validate input
  if [ -z $filepath ]; then
    echo "Missing file path"
    exit 1
  elif ! [ -e $filepath ]; then
    echo "Invalid file path"
    exit 1
  fi

  echo "starting app"
  node $filepath
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
  filepath=$2
  start $filepath
elif [ $command = "stop" ]; then
  stop
else
  echo "Invalid command. Please use 'start' or 'stop'"
fi

exit 0