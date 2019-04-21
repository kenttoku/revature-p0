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

# login
az login -u $username

# get list of admins
az role assignment list \
  --include-classic-administrators \
  --query "[?id=='NA(classic admins)'].principalName"