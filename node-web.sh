#!/bin/bash
# automate the process of starting, stopping a node web application

start()
{
  echo "starting app"
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
  start
elif [ $command = "stop" ]; then
  stop
else
  echo "Invalid command. Please use 'start' or 'stop'"
fi