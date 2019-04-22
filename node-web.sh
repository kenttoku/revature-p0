#!/bin/bash
# automate the process of starting, stopping a node web application

##### FUNCTIONS #####
start()
{
  directory=$1

  # validate input
  if [ -z $directory ]; then
    echo "Missing directory" 1>&2
    exit 1
  fi

  if ! [ -d $directory ]; then
    echo "Invalid directory" 1>&2
    exit 1
  fi

  # change to directory
  cd $directory

  if ! [ -e $directory/package.json ]; then
    echo "Directory does not contain package.json"
  fi

  # start project
  npm start
}

stop()
{
  name=$1

  # stop all node apps when nothing is specified
  # otherwise, stop based on name search
  if [ -z $name ]; then
    killall node
  else
    # show all, show users, show processes not attatched to terminal
    # filtering using grep. array[1] corresponds to the pid
    ps aux | grep -E '\snode\s' | grep -E $name | while read -a array
    do
      kill "${array[1]}"
    done
  fi
}


##### VARIABLES #####
command=$1

##### MAIN #####
# validate command
if [ -z $command ]; then
  echo "Missing command. Please use 'start' or 'stop'"
  exit 1
fi

# validate command
if [ $command != "start" ] && [ $command != "stop" ]; then
  echo "Invalid command. Please use 'start' or 'stop'"
  exit 1
fi

# Run the functions
$command $2

exit 0