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
  username=$1
  userdisplayname=$2
  usersubscription=$3

  DOMAIN=kenttokunagagmail.onmicrosoft.com
  userprincipalname=$userdisplayname@$DOMAIN
  login $username

  user=$(az ad user list \
  --query [].userPrincipalName \
  | grep -E $userprincipalname)

  if [ -z $user ]; then
  az ad user create \
    --display-name $userdisplayname \
    --password $random \
    --user-principal-name $userprincipalname \
    --force-change-password-next-login \
    --subscription $usersubscription
  fi
}

assign_role()
{
  username=$1
  login $username

}

delete_user()
{
  username=$1
  login $username
}


# main

## variables and constants
PASSWORD=revature2019!
command=$1
username=$2

##
if [ $command = "create" ]; then
  userdisplayname=$3
  usersubscription=$4
  create_user $username $userdisplayname $userprincipalname
elif [ $command = "assign" ]; then
  assign_role $username
elif [ $command = "delete" ]; then
  delete_user $username
else
  echo "invalid command"
fi