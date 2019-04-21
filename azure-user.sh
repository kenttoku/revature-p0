#!/bin/bash
# automate the process of creating, assigning, deleting a directory user
# include: azure, must be admin,
# add role of reader or contributor to subscription,
# remove role of reader or contributor to subscription, delete non-admin only,
# 1 script with 3 functions

# functions
# checks if you are logged in as the account provided
login_check()
{
  username=$1

  check=$(az account show \
  --query user.name \
  | grep -E $username)

  echo $check
}

# checks if the user is an admin
admin_check()
{
  principalname=$1

  check=$(az role assignment list \
    --include-classic-administrators \
    --query "[?id=='NA(classic admins)'].principalName" \
    | grep -E $principalname)

  echo $check
}

# logs user in
login()
{
  username=$1

  # checks for arguments
  if [ -z $username ]; then
    echo "please specify username" 1>&2
    exit 1
  fi

  # skip login if you are already logged in as the specified user
  # otherwise, login
  echo "checking if user is already logged in"
  currentuser=$(login_check $username)

  if [ -z $currentuser ]; then
    echo "logging in"
    az login -u $username
  else
    echo "already logged in. skipping login"
  fi

  # must be admin to run commands
  echo "checking if current user is an admin"
  check=$(admin_check $username)

  if [ -z $check ]; then
    echo "must be admin" 1>&2
    exit 1
  fi

  echo "validated user"
}

# the create command
# creates the user
create_user()
{
  PASSWORD=revature2019!
  DOMAIN=kenttokunagagmail.onmicrosoft.com
  userdisplayname=$1
  usersubscription=$2
  userprincipalname=$userdisplayname@$DOMAIN

  # validate arguments
  if [ -z $userdisplayname ]; then
    echo "must provide display name" 1>&2
    exit 1
  elif [ -z $usersubscription ]; then
    echo "must provide subscription" 1>&2
    exit 1
  fi

  # check if the user already exists
  user=$(az ad user list \
    --query [].userPrincipalName \
    | grep -E $userprincipalname)

  if [ -z $user ]; then
    echo "creating user"
    az ad user create \
      --display-name $userdisplayname \
      --password $PASSWORD \
      --user-principal-name $userprincipalname \
      --force-change-password-next-login \
      --subscription $usersubscription
  else
    echo "user already exists" 1>&2
    exit 1
  fi
}

assign_role()
{
  echo "assign"
  # az role assignemnt create --assinnee --role
}

delete_user()
{
  username=$1
  DOMAIN=@kenttokunagagmail.onmicrosoft.com

  # validates arguments
  if [ -z $username ]; then
    echo "must provide username" 1>&2
    exit 1
  fi

  # adds domain to username if omitted
  usernamecheck=$(echo "$username" | grep -E $DOMAIN)

  if [ -z $usernamecheck ]; then
    userprincipalname=${username}${DOMAIN}
  else
    userprincipalname=$username
  fi

  # check if the user exists
  user=$(az ad user list \
    --query [].userPrincipalName \
    | grep -E $userprincipalname)

  if [ -z $user ]; then
    echo "user does not exist" 1>&2
    exit 1
  else
    echo "deleting user"
    az ad user delete --upn-or-object-id $userprincipalname
  fi
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
  username=$3
  delete_user $username
else
  echo "invalid command"
fi