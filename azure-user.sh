#!/bin/bash
# automate the process of creating, assigning, deleting a directory user
# include: azure, must be admin,
# add role of reader or contributor to subscription,
# remove role of reader or contributor to subscription, delete non-admin only,
# 1 script with 3 functions
source ~/.profile

## variables and constants
DOMAIN=kenttokunagagmail.onmicrosoft.com
PASSWORD=revature2019!
username=$1
userdisplayname=$3
usersubscription=$4
userprincipalname=$userdisplayname@$DOMAIN

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

  echo "$check"
}

login $username
isAdmin=$(admin_check $username)

# # get list of admins
# az role assignment list \
#   --include-classic-administrators \
#   --query "[?id=='NA(classic admins)'].principalName"