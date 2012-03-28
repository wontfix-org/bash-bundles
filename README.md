# Bash Bundles

Like pathogen for bash, allows to easily use and share snippets of shellscripts.

# Installation

Clone the main repository into an arbitrary directory and source the script somewhere in your bashrc:

    git clone git@github.com:wontfix-org/bash-bundles.git ~/.bash.bundles
    echo 'source $HOME/.bash.bundles/bashrc.bundles' >> $HOME/.bashrc

# Usage

To add a new bundle, put one into the ~/.bb.autoload directory. The minimum requirement
is a bundle file in the root directory of the bundle, that can be sourced. It does not
matter if its a cloned git repository or a handcrafted directory structure.

# Features

 * If there is a bin/ directory in your bundle, its automatically added to your $PATH

