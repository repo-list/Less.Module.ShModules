#!/bin/sh

# Module Name : log.sh
# Description : Module for simple logging
# Naming Convention : uppercase & leading __ for global variables, lowercase for local variables

__LOG_DIR_CURRENT="$(dirname $0)"
__LOG_FILE_CURRENT="$(basename $0)"
__LOG_HEADER="$__LOG_FILE_CURRENT"
__LOG_DIR_LOGS="$__LOG_DIR_CURRENT/logs"

# function log_to_all : Log to STDOUT and also Log to a specified file
# param $1 : filename
# param $2 : message
log_to_all () {
    log_to_stdout "$2"
    log_to_file "$1" "$2"
}

# function log_to_stdout : Log to STDOUT
# param $1 : message
log_to_stdout () {
    echo "$__LOG_HEADER: $1"
}

# function log_to_file : Log to a specified file
# param $1 : filename
# param $2 : message
log_to_file () {
    if [ ! -d "$__LOG_DIR_LOGS" ]; then
        mkdir -p "$__LOG_DIR_LOGS"
    fi

    if [ ! -f "$__LOG_DIR_LOGS/$1" ]; then
        touch "$__LOG_DIR_LOGS/$1"
    fi

    echo "$__LOG_HEADER: $2" >> "$__LOG_DIR_LOGS/$1"
}