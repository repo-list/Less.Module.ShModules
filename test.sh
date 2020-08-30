#!/bin/sh

## Name : Test Script
## How to :
## 1) Modify this script file to meet your tastes
## 1-A) Change the value of $USERNAME below to your target user's name (default is "ec2-user")
## 1-B) Uncomment in function "test_bash_profile", in Run Section, a line which you want to execute
##
## 2) Transfer this script and modules through whatever method you prefer e.g. through SFTP
## $ sftp username@remoteaddr
## $ put -r ShModules ShModules
##
## 3) Set file permissions and remove unnecessary files if exists
## $ chmod -R u+rwX,go+rX,go-w ShModules
## $ find ShModules -name "*.sh" -exec chmod 755 {} +
## $ rm -r ShModules/.git*
##
## 4) Everything's ready, let's run this script
## $ ShModules/test.sh

# User
USERNAME="ec2-user"

# Internal Settings
FILE_CURRENT="$(basename $0)"
DIR_CURRENT="$(dirname $0)"
DIR_MODULES="$DIR_CURRENT/modules"
MODULE_USER="$DIR_MODULES/user.sh"
MODULE_LOG="$DIR_MODULES/log.sh"
MODULE_BASH_PROFILE="$DIR_MODULES/bash_profile.sh"
MODULE_PATH="$DIR_MODULES/path.sh"

###########################################################################################

# Including Modules
. "$MODULE_USER"
. "$MODULE_PATH"
. "$MODULE_LOG"
. "$MODULE_BASH_PROFILE"

# function test_user : tests modules/user.sh
test_user () {
    # Prepare Section

    # Run Section
    if [ $(user_is_root) ]; then
        echo "test_user // You are running this script as a root user."
    else
        echo "test_user // You are running this script as a non-root user."
    fi
}

# function test_path : tests modules/path.sh
test_path () {
    # Prepare Section

    # Run Section
    _dir_home="$(path_get_user_home $USERNAME)"
    if [ -z "$_dir_home" ]; then
        echo "test_path // path_get_user_home - Unsupported OS Type"
    else
        echo "test_path // User home path : $_dir_home"
    fi
}

# function test_log : tests modules/log.sh
test_log () {
    # Prepare Section
    echo "test_log // Log Header : $__LOG_HEADER"
    echo "test_log // Log Dir Logs : $__LOG_DIR_LOGS"

    if [ -e "$__LOG_DIR_LOGS" ]; then
        $(rm -r "$__LOG_DIR_LOGS")
    fi
    
    _dir_home="$(path_get_user_home $USERNAME)"
    _dir_new_logs="$_dir_home/new_logs"

    # Run Section
    log_to_stdout "Test : log_to_stdout"
    log_to_file "test_log_01.log" "Test : log_to_file"
    log_to_all "test_log_02.log" "Test : log_to_all"

    log_set_header "My Log Header^-^"
    log_set_dir "$_dir_new_logs"
    log_to_stdout "Test : log_to_stdout 2"
    log_to_file "test_log_03.log" "Test : log_to_file 2"
    log_to_all "test_log_04.log" "Test : log_to_all 2"
}

# function test_bash_profile : tests modules/bash_profile.sh
# Uncomment a line which you want to execute in Run Section
test_bash_profile () {
    # Prepare Section
    _dir_home="$(path_get_user_home $USERNAME)"
    _dir_pathtest="$_dir_home/pathtest"
    _file_temptest="$_dir_pathtest/temp_test.sh"
    echo "test_bash_profile // Dir PathTest : $_dir_pathtest"

    if [ ! -d "$_dir_pathtest" ]; then
        mkdir -p "$_dir_pathtest"
    fi

    if [ ! -f "$_file_temptest" ]; then
        touch "$_file_temptest"
        echo "#!/bin/sh" >> "$_file_temptest"
        echo "" >> "$_file_temptest"
        echo "echo \"pathtest -> temp_test\"" >> "$_file_temptest"
        chmod +x $_file_temptest
    fi

    # Run Section
    #bash_profile_add_to_path "$USERNAME" "$_dir_pathtest"
    #bash_profile_remove_from_path "$USERNAME" "$_dir_pathtest"
}

###########################################################################################

echo "Starting Test ..."
echo ""

test_user
test_path
test_log
test_bash_profile

echo ""
echo "Finishing Test ..."