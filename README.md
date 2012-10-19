# Bash Bundles

Like pathogen for bash, allows to easily use and share snippets of shellscripts.

# Installation

Clone the main repository into an arbitrary directory and source the script somewhere in your bashrc:

    git clone git@github.com:wontfix-org/bash-bundles.git ~/.bash.bundles
    echo 'source $HOME/.bash.bundles/bashrc' >> $HOME/.bashrc

# Usage

To add a new bundle, put one into the ~/.bb.autoload directory. The minimum requirement
is a bundle file in the root directory of the bundle, that can be sourced. It does not
matter if its a cloned git repository or a handcrafted directory structure.

# Features

## Automatic PATH extension

If there is a bin/ directory in your bundle, its automatically added to your $PATH

## Custom bashrc.<topic> includes

	BB_LOAD_FILES="completion ?ruby utils gentoo ?$(hostname -s) ?$(hostname -f)"

This will load files named "bashrc.<topic>", topics prefixed with a ? may not exists
without an error being thrown. Topics prefixed with a ! are not loaded.
