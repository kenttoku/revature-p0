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
    ./git-node-projects.sh [directoy]
      Validates the dev environment to make sure brew, node, git and azure-cli is installed.


```

### azure-user.sh

```
  Usage:

```

### node-web.sh

```
  Usage:
    ./node-web.sh start location - Starts a node app at the specified location.
    ./node-web.sh stop [name] - Stops all node apps. If name
    is specified, stops all node apps with that includes the name.
```

## Authors

* **Kent Tokunaga** - [kenttoku](https://github.com/kenttoku)

## License

This project is licensed under the MIT License - see the [license](license) file for details

## Acknowledgments

[Fred Belotte](https://github.com/fredbelotte)
