#!/bin/bash
# automate the process of creating, assigning, deleting a directory user
# include: azure, must be admin,
# add role of reader or contributor to subscription,
# remove role of reader or contributor to subscription, delete non-admin only,
# 1 script with 3 functions

# functions
login()
{
  username=$1
  az login -u $username
}

admin_check()
{
  principalname=$1

  check=$(az role assignment list \
    --include-classic-administrators \
    --query "[?id=='NA(classic admins)'].principalName" \
    | grep $principalname)

  if [ -z $check ]; then
    echo "must be admin" 1>&2
    exit 1
  fi
}

create_user()
{
  username=$1
  login $username
  admin_check $username
}


# main

## variables and constants
DOMAIN=kenttokunagagmail.onmicrosoft.com
PASSWORD=revature2019!
command=$1
username=$2
userdisplayname=$3
usersubscription=$4
userprincipalname=$userdisplayname@$DOMAIN

##
if [ $command = "create" ]; then
  create_user $username
elif [ $command = "assign" ]; then
  echo "assign"
elif [ $command = "delete" ]; then
  echo "delete"
else
  echo "invalid command"
fi