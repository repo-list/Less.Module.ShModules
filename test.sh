#!/bin/sh

# Tester for modules

USERNAME="$(whoami)"
DIR_CURRENT="$(dirname $0)"
FILE_CURRENT="$(basename $0)"

DIR_MODULES="$DIR_CURRENT/modules"
MODULE_LOG="$DIR_MODULES/log.sh"
MODULE_BASH_PROFILE="$DIR_MODULES/bash_profile.sh"

###########################################################################################

# function test_log : tests modules/log.sh
test_log () {
    # Include
    . "$MODULE_LOG"

    # Prepare
    echo "Log Header : $__LOG_HEADER"
    echo "Log Dir Current : $__LOG_DIR_CURRENT"
    echo "Log Dir Logs : $__LOG_DIR_LOGS"

    if [ -e "$__LOG_DIR_LOGS" ]; then
        $(rm -r "$__LOG_DIR_LOGS")
    fi

    # Run
    log_to_stdout "Test : log_to_stdout"
    log_to_file "test_log_01.log" "Test : log_to_file"
    log_to_all "test_log_02.log" "Test : log_to_all"
}

# function test_bash_profile : tests modules/bash_profile.sh
test_bash_profile () {
    # Include
    . "$MODULE_BASH_PROFILE"

    # Prepare
    DIR_PATHTEST="/home/$USERNAME/pathtest"
    FILE_PATHTEST_TEMPTEST="$DIR_PATHTEST/temp_test.sh"

    if [ ! -d "/home/$USERNAME/pathtest" ]; then
        mkdir -p "$DIR_PATHTEST"
    fi

    if [ ! -f "$FILE_PATHTEST_TEMPTEST" ]; then
        touch "$FILE_PATHTEST_TEMPTEST"
        echo "#!/bin/sh" >> "$FILE_PATHTEST_TEMPTEST"
        echo "" >> "$FILE_PATHTEST_TEMPTEST"
        echo "echo \"pathtest -> temp_test\"" >> "$FILE_PATHTEST_TEMPTEST"
        chmod +x $FILE_PATHTEST_TEMPTEST
    fi

    # Run
    #bash_profile_add_to_path "$USERNAME" "\$HOME/pathtest"
    bash_profile_remove_from_path "$USERNAME" "\$HOME/pathtest"
}


###########################################################################################

echo "Starting Test ..."
echo ""

#test_log
test_bash_profile

echo ""
echo "Finishing Test ..."