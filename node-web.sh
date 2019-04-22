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

  # check directory for package.json
  if ! [ -e package.json ]; then
    echo "Directory does not contain package.json" 1>&2
    exit 1
  fi

  # check package.json for  "start" script
  startscript=$(cat package.json | grep "start")

  if [ -z $startscript ]; then
    echo "package.json does not contain 'start' script." 1>&2
    exit 1
  fi

  # start project
  npm start
}

stop()
{
  ps aux | grep -E '\snode\s' | while read -a array
  do
    kill "${array[1]}"
  done
}

##### VARIABLES #####
command=$1

##### MAIN #####
## check for node
node=$(which node)

if [ -z $node ]; then
  echo "No node. Please install before continuing." 1>&2
  exit 1
fi

# validate command
if [ -z $command ]; then
  echo "Missing command. Please use 'start' or 'stop'"
  exit 1
fi

# # validate command
# if [ $command != "start" ] && [ $command != "stop" ]; then
#   echo "Invalid command. Please use 'start' or 'stop'"
#   exit 1
# fi
case "$command" in
  "start")
    start $2
  ;;
  "stop")
    stop $2
  ;;
  *)
    echo "Invalid command. Please use 'start' or 'stop'"
    exit 1
  ;;
esac
# Run the functions
$command $2

exit 0