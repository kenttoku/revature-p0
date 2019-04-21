#!/bin/bash

##### FUNCTIONS #####
## Creates the User
create()
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

## Assigns roles to a user
role()
{
  roleaction=$1
  username=$2
  role=$(echo "$3" | tr '[:upper:]' '[:lower:]')

  # validates arguments existence
  if [ -z $roleaction ]; then
    echo "must provide role action" 1>&2
    exit 1
  elif [ -z $username ]; then
    echo "must provide username" 1>&2
    exit 1
  elif [ -z $role ]; then
    echo "must provide role" 1>&2
    exit 1
  fi

  # validates roleaction
  if [ $roleaction != "create" ] && [ $roleaction != "delete" ]; then
    echo "invalid role action. please use create or delete" 1>&2
    exit 1
  fi

  # validates roleaction
  if [ $role != "reader" ] && [ $role != "contributer" ]; then
    echo "invalid role. please use reader or contributor" 1>&2
    exit 1
  fi

  az role assignemnt $roleaction --assignee $username --role $role
}

## Deletes a non-admin user
delete()
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

  # do not delete if user is admin
  admincheck=$(admin_check $userprincipalname)

  if ! [ -z $admincheck ]; then
    echo "You may not delete another admin" 1>&2
    exit 1
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

##### MAIN #####
## Variables
command=$1
username=$2

## Validate command
if [ $command != "create" ] && [ $command != "role" ] && [ $command != "delete" ]; then
  echo "invalid command" 1>&2
  exit 1
fi

# checks for arguments
if [ -z $username ]; then
  echo "please specify username" 1>&2
  exit 1
fi

# skip login if you are already logged in as the specified user
# otherwise, login
echo "checking if user is already logged in"
currentuser=$(az account show \
  --query user.name \
  | grep -E $username)

if [ -z $currentuser ]; then
  echo "logging in"
  az login -u $username
else
  echo "already logged in. skipping login"
fi

# must be admin to run commands
echo "checking if current user is an admin"
check=$(az role assignment list \
    --include-classic-administrators \
    --query "[?id=='NA(classic admins)'].principalName" \
    | grep -E $username)

if [ -z $check ]; then
  echo "must be admin" 1>&2
  exit 1
fi

echo "validated user"

$command $3 $4 $5