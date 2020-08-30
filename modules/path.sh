#!/bin/sh

# Module Name : path.sh
# Description : Module for simple path-related functionalities
# Naming Convention : uppercase & leading __ for global variables, lowercase for local variables

__PATH_FILE_MODULE="path.sh"

# function path_get_user_home : get the target user's home path based on current OS
# param $1 : username
path_get_user_home () {
    __path_user_home=""
    if [ "$OSTYPE" = "linux-gnu" ]; then
        # for Linux Distributions
        __path_user_home="/home/$1"
    elif [ "$OSTYPE" = "darwin" ]; then
        # for Mac OSX
        __path_user_home="/Users/$1"
    else
        # else (Unsupported OS Type)
        echo ""
        return
    fi

    echo "$__path_user_home"
}