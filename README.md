# Bash Bundles

Like pathogen for bash, allows to easily use and share snippets of shellscripts.

# Installation

Clone the main repository into an arbitrary directory and source the script somewhere in your bashrc:

    git clone git://github.com/wontfix-org/bash-bundles.git ~/.bash.bundles
    echo 'source $HOME/.bash.bundles/bashrc' >> $HOME/.bashrc

# Usage

To add a new bundle, clone/put a bundle directory into the ~/.bb.autoload directory. The minimum requirement is a bash sourceable bundle file in the root directory of the bundle. It does not matter if its a cloned git repository or a handcrafted directory structure.

# Features

## Automatic PATH extension

If there is a bin/ directory in your bundle, its automatically added to your $PATH

## Custom bashrc.<topic> includes

	BB_LOAD_FILES="completion ?ruby utils gentoo ?$(hostname -s) ?$(hostname -f)"

This will load files named ".bashrc.YOUR_TOKEN", files prefixed with a ? do not produce errors if they are missing.

## Vundle-like package management

You can place a file named *bundles* into your BB_ROOT-directory, containing git repo URLs (one repo per line) pointing at a bash bundle. These will be checked out and can be updated using the *bb_update* shell function.

Example *bundles*-file:

    https://github.com/wontfix-org/bash-bundles-nscreen.git
    https://github.com/wontfix-org/bash-bundles-autoremote.git

This would auto-checkout the two bundles whenever you initially source the main bash-bundles bashrc.
