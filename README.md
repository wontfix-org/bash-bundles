# Bash Bundles

My personal bash plugin manager, for sharing small bash snippets and structuring your bashrc into multiple files.

# Installation

Clone the main repository into an arbitrary directory and source the script somewhere in your bashrc:

    git clone git://github.com/wontfix-org/bash-bundles.git ~/.bash.bundles
    echo 'source $HOME/.bash.bundles/bashrc' >> $HOME/.bashrc

# Usage

To add a new bundle, clone/put a bundle directory into the `~/.bb.autoload` directory. The minimum requirement is a bash sourceable bundle file in the root directory of the bundle. It does not matter if its a cloned git repository or a handcrafted directory structure.

# Features

## Automatic PATH extension

If there is a bin/ directory in your bundle, its automatically added to your $PATH

## Custom bashrc.<topic> includes

	BB_LOAD_FILES="completion ?ruby utils gentoo ?$(hostname -s) ?$(hostname -f)"

This will load files named ".bashrc.YOUR_TOKEN", files prefixed with a ? do not produce errors if they are missing.

## Vundle-like package management

You can add git URLs to a file `~/.bash.bundles/bundles`, these can be installed and updated by running the `bb_update` command.
When the `~/.bb.autoload` directory does not exist, `bb_update` is called automatically the first time you open a new shell.

Example `bundles`-file:

```
https://github.com/wontfix-org/bash-bundles-nscreen.git
https://github.com/wontfix-org/bash-bundles-autoremote.git
```
