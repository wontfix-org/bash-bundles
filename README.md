# Bash Bundles

My personal bash bundle (plugin) manager, for sharing small bash snippets and structuring your bashrc into multiple files.

# Installation

Clone the main repository into an arbitrary directory and source the script somewhere in your bashrc:

```bash
git clone git://github.com/wontfix-org/bash-bundles.git ~/.bash.bundles
echo 'source $HOME/.bash.bundles/bashrc' >> $HOME/.bashrc
```

# What does it do?

## Manage standalone bundles

Bundles live in `~/.bb.autoload/`, a bundle directory needs to contain a file named `bundle`. The file is sourced
into your current bash environment. In addition, if the bundle directory contains a `bin/` directory, it is added
to your `PATH` for convenience.

## Automatic install and update

To make life a little easier, you can add git URLs to `~/.bash.bundles/bundles`, the repos are installed and updated
into `~/.bb.autoload` when you run `bb_update`.

Example `bundles`-file:

```
https://github.com/wontfix-org/nt.git
https://github.com/wontfix-org/bash-bundles-autoremote.git
```

## Structure you bashrc

In order to give a little more structure to all your private bash customizations, you can pull parts out into seperate
files `.bashrc.<topic>` and make bash.bundles load them in the order you want or even make some of the files dynamic
and/or optional, by setting a variable `BB_LOAD_FILES` before sourcing `bash.bundles/bashrc`:

```bash
BB_LOAD_FILES="completion ?utils ?$(hostname -s) ?$(hostname -f)"
```

This will always load a file `~/.bashrc.completion` as well as `~/.bashrc.utils` if it exists. Also, we include files
with the current hostname and fqdn as a topic, this will allow us to customize our bash environment on a per host basis.
Also, if you are managing your config files in a VCS, this will allow you to add all your "local" config files to the
repo while only sourcing the required one on every host.
