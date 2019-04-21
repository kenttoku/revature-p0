#!/bin/bash
# automate the process of starting, stopping a node web application

##### FUNCTIONS #####
start()
{
  location=$1

  # validate input
  if [ -z $location ]; then
    echo "Missing location"
    exit 1
  fi

  if ! [ -d $location ] && ! [ -e $location ]; then
    echo "Invalid location"
    exit 1
  fi

  # if the location provided is a directory, run the npm start script
  if [ -d $location ]; then
    cd $location
    npm start
  fi

  # if the location provided is a file, run using node
  if [ -e $location ]; then
    node $location
  fi
}

stop()
{
  name=$1

  # stop all node apps when nothing is specified
  # otherwise, stop based on name search
  if [ -z $name ]; then
    killall node
  else
    ps | grep -E '\snode\s' | grep -E 'web-app' | while read -a array
    do
      kill "${array[0]}"
    done
  fi
}

##### MAIN #####

command=$1
if [ -z $command ]; then
  echo "Missing command. Please use 'start' or 'stop'"
  exit 1
fi

if [ $command != "start" ] && [ $command != "stop" ]; then
  echo "Invalid command. Please use 'start' or 'stop'"
  exit 1
fi

# Run the functions
$command $2

exit 0