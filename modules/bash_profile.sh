#!/bin/sh

# Module Name : bash_profile.sh
# Description : Module for simple bash profile handling
# Naming Convention : leading __ for all, uppercase for globals, lowercase for locals

__BASH_PROFILE_FILE_MODULE="bash_profile.sh"

# function bash_profile_add_to_path : Add to PATH variable
# param $1 : username
# param $2 : dir (full path)
bash_profile_add_to_path () {
    echo "export PATH=\"\$PATH:$2\"" >> "/home/$1/.bash_profile"
}

# function bash_profile_remove_from_path : Remove a line containing a specific string from PATH variable
# param $1 : username
# param $2 : sub-string
bash_profile_remove_from_path () {
    __file_profile=""
    if [ "$OSTYPE" = "linux-gnu" ]; then
        # for Linux Distributions
        __file_profile="/home/$1/.bash_profile"
    elif [ "$OSTYPE" = "darwin" ]; then
        # for Mac OSX
        __file_profile="/Users/$1/.bash_profile"
    else
        # else
        1>&2 echo "$__BASH_PROFILE_FILE_MODULE: Unsupported OS Type"
        return
    fi

    # get line numbers
    __target_lines="$(cat $__file_profile | grep -n 'export PATH' | grep $2 | cut -d ':' -f1)"
    # reverse list
    __target_lines="$(echo $__target_lines | awk '{ for (i = NF; i > 0; i--) printf("%s ", $i); }')"

    # delete lines
    for line in $__target_lines; do
        if [ "$OSTYPE" = "linux-gnu" ]; then
            # for Linux Distributions
            sed -i "${line}d" "$__file_profile"
        elif [ "$OSTYPE" = "darwin" ]; then
            # for Mac OSX
            sed -i '' "${line}d" "$__file_profile"
        else
            # else
            1>&2 echo "$__BASH_PROFILE_FILE_MODULE: Unsupported OS Type"
            return
        fi
    done
}