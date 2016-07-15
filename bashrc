#!/usr/bin/env bash

export BB_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export BB_BUNDLE_PATH=${BB_BUNDLE_PATH:-$HOME/.bb.bundles/}
export BB_AUTOLOAD_PATH=${BB_AUTOLOAD_PATH:-$HOME/.bb.autoload/}
export BB_INFO=${BB_INFO:-false}
export BB_DEBUG=${BB_DEBUG:-false}
export BB_FILES_PATH=${BB_FILES_PATH:-$HOME}
export BB_FILES_PREFIX=${BB_FILES_PREFIX:-.bashrc.}
export BB_FILES_SUFFIX=${BB_FILES_SUFFIX:-}
export BB_LOAD_FILES=${BB_LOAD_FILES:-}
export BB_BUNDLES_FILE=${BB_BUNDLES_FILE:-$BB_ROOT/bundles}


function bb_info() {
	$BB_INFO && echo "$@"
}


function bb_debug() {
	$BB_DEBUG && echo "$@"
}


function bb_error() {
	echo "$@" >&2
}


function bb_find_bundles() {
	find -L "$@" -maxdepth 2 -mindepth 2 -type f -name bundle
}


function bb_source() {
	local file=$1
	bb_info "Loading $file"
	source $file
}


function bb_load_bundle() {
	local broot=$(dirname "$bundle")
	if ! [ -f "$bundle" ] ; then
		log_error "Bundle not found: $bundle"
		return
	fi
	bb_debug "Checking for bin directory in $broot/bin/"
	if [ -d $broot/bin/ ] ; then
		bb_extend_path $broot/bin/
	fi
	bb_source $bundle
}


function bb_extend_path() {
	local path="$1"
	if [[ ":$PATH:" == *":$path:"* ]] ; then
		bb_debug "Found '$path' already in path, skipping"
		return
	fi
	bb_info "Extending path with $broot/bin"
	PATH="$PATH:$path"
}


function bb_autoload_bundles() {
	local bundle=
	if ! [ -d $BB_AUTOLOAD_PATH ] ; then
		bb_info "Autoload directory $BB_AUTOLOAD_PATH does not exist"
		return
	fi
	bb_info "Loading bundles from $BB_AUTOLOAD_PATH"
	for bundle in $(bb_find_bundles $BB_AUTOLOAD_PATH) ; do
		bb_load_bundle $bundle
	done
}


function bb_load_bundles() {
	local bundle=
	if ! [ -d $BB_BUNLDE_PATH ] ; then
		bb_info "Bundle directory $BB_BUNDLE_PATH does not exist"
		return
	fi
	bb_info "Loading bundles from $BB_BUNDLE_PATH"
	for bundle in $BB_LOAD_BUNDLES ; do
		if [[ $bundle =~ /* ]] ; then
			bb_load_bundle $bundle/bundle
		else
			bb_load_bundle $BUNDLE_BUNDLE_PATH/$bundle/bundle
		fi
	done
}


function bb_file() {
	echo ${BB_FILES_PATH}/${BB_FILES_PREFIX}${name}${BB_FILES_SUFFIX}
}


function bb_load_files() {
	local file=
	local name=
	local optional=
	bb_info "Loading files"
	for name in $BB_LOAD_FILES ; do
		if [[ $name == \?* ]] ; then
			optional=true
			name=${name#\?}
		elif [[ $name == \!* ]] ; then
			name=${name#\!}
			file=$(bb_file $name)
			bb_info "Skipping $file"
			continue
		else
			optional=false
		fi

		file=$(bb_file $name)
		if [[ -f $file ]] ; then
			bb_source $file
		elif ! $optional ; then
			bb_error "Could not find file '$file' for name '$name'"
		else
			bb_info "Could not find file '$file', but it was optional"
		fi
	done
}


function bb_update() {
    local bundle=
    local name=
    if [[ -f $BB_BUNDLES_FILE ]]; then
        while read bundle; do
            name=$(basename $bundle)
            name=${name%%.git}
            bb_info "Found $name";
            if [[ -d ${BB_AUTOLOAD_PATH}/${name} ]]; then
                bb_info "Updating $name"
                (cd ${BB_AUTOLOAD_PATH}/${name}; git pull)
            else
                bb_info "Cloning $name"
                git clone $bundle ${BB_AUTOLOAD_PATH}/${name}
            fi
        done <$BB_BUNDLES_FILE
    fi
}


function bb_auto_create() {
    if [[ ! -d $BB_AUTOLOAD_PATH ]]; then
        mkdir -p $BB_AUTOLOAD_PATH
        bb_update
    fi
}

bb_auto_create
bb_autoload_bundles
bb_load_bundles
bb_load_files
