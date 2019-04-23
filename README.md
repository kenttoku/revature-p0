# Project 0

A set of scripts to:
* automate the process of provisioning a new linux virtual machine
* automate the process of setting up a new git project repository structure
* automate the process of creating, assigning, deleting a directory user
* automate the process of starting, stopping a node web application

## Scripts


### linux-setup.sh

```
  Usage: automate the process of provisioning a new linux virtual machine
    Installs linuxbrew, node, git, azure-cli

    ./linux-setup.sh
```

### git-node-projects.sh

```
  Usage:
    ./git-node-projects.sh directory gituseremail gitusername
      Validates the dev environment to make sure git and node are installed.
      Creates a new git project repository structure using the directory, git user email, and git user name provided.
```

### azure-user.sh

```
  Usage:
    ./azure-user.sh create username subscription - Creates an user with the username and subscription specified.
    ./azure-user.sh role action user role - Assigns the role to an user. Action may be create or delete.
    ./azure-user.sh delete user - Deletes a non-admin user.
```

### node-web.sh

```
  Usage:
    ./node-web.sh start directory - Checks the directory for a "start" script in the package.json. Runs npm start if it is found.
    ./node-web.sh stop directory - Checks the directory for a "stop" script in the package.json. Runs npm stop if it is found.
```

## Authors

* **Kent Tokunaga** - [kenttoku](https://github.com/kenttoku)

## License

This project is licensed under the MIT License - see the [license](license) file for details

## Acknowledgments

[Fred Belotte](https://github.com/fredbelotte)
