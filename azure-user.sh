#!/bin/bash
# automate the process of creating, assigning, deleting a directory user
# include: azure, must be admin,
# add role of reader or contributor to subscription,
# remove role of reader or contributor to subscription, delete non-admin only,
# 1 script with 3 functions

# functions
admin_check()
{
  principalname=$1

  check=$(az role assignment list \
    --include-classic-administrators \
    --query "[?id=='NA(classic admins)'].principalName" \
    | grep -E $principalname)

  echo $check
}

login()
{
  username=$1
  if [ -z $username ]; then
    echo "please specify username" 1>&2
    exit 1
  fi
  az login -u $username

  check=$(admin_check $username)

  if [ -z $check ]; then
    echo "must be admin" 1>&2
    exit 1
  fi
}

create_user()
{
  PASSWORD=revature2019!
  DOMAIN=kenttokunagagmail.onmicrosoft.com
  userdisplayname=$1
  usersubscription=$2
  userprincipalname=$userdisplayname@$DOMAIN

  user=$(az ad user list \
  --query [].userPrincipalName \
  | grep -E $userprincipalname)

  echo $user
  if [ -z $user ]; then
  az ad user create \
    --display-name $userdisplayname \
    --password $PASSWORD \
    --user-principal-name $userprincipalname \
    --force-change-password-next-login \
    --subscription $usersubscription
  fi
}

assign_role()
{
  # az role assignemnt create --assinnee --role
}

delete_user()
{
}


# main

## variables and constants
command=$1
username=$2

login $username
##
if [ $command = "create" ]; then
  userdisplayname=$3
  usersubscription=$4
  create_user $userdisplayname $usersubscription
elif [ $command = "assign" ]; then
  assign_role
elif [ $command = "delete" ]; then
  delete_user
else
  echo "invalid command"
fi