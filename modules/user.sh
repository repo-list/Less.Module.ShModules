#!/bin/sh

# Module Name : user.sh
# Description : Module for simple user-related functionalities
# Naming Convention : uppercase & leading __ for global variables, lowercase for local variables

# function user_is_root : check if current user is root
user_is_root () {
    if [ $EUID == 0 ]; then
        return 1
    else
        return 0
    fi
}