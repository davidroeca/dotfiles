#!/bin/bash

# ------------------------------------------------
# Script used to copy vimrc file to and from
# personal home directory.
#
# Could be scaled later to provide further
# functionality with different home paths and 
# potentially an array of files other than vimrc
# as well.
# ------------------------------------------------

FILE_NAME='.vimrc'
MACHINE_DIR='/home/david/' # directory on machine
REPO_DIR=${MACHINE_DIR}'Scripts/myconfig/config_files/'

function confirm {
# this function follows a yes/no question
# proceeds upon 'y' and exits upon 'n'
    BAD_INPUT=true
    while [ $BAD_INPUT == true ]
    do
        echo '(y/n)'
        read INPUT
        if [ "$INPUT" == 'y' ]
        then
            BAD_INPUT=false
        elif [ "$INPUT" == 'n' ]
        then
            echo 'Abort.'
            exit 0 
        else
            echo ${BAD_INPUT}
            echo 'Please try again.'
        fi
    done
}

if [ "$#" -ge 1 ] && [ "$1" == '-o' ] # -o represents overwrite
then
    # handle case where we want to write to the repo
    echo 'Write '${MACHINE_DIR}${FILE_NAME}' to '${REPO_DIR}${FILE_NAME}'?'
    confirm
    cp ${MACHINE_DIR}${FILE_NAME} ${REPO_DIR}${FILE_NAME}
    echo 'wrote '${MACHINE_DIR}${FILE_NAME}' to '${REPO_DIR}${FILE_NAME}'.'
else
    # handle default case where we write repo to machine
    echo 'Write '${REPO_DIR}${FILE_NAME}' to '${MACHINE_DIR}${FILE_NAME}'?'
    confirm
    cp ${REPO_DIR}${FILE_NAME} ${MACHINE_DIR}${FILE_NAME}
    echo 'wrote '${REPO_DIR}${FILE_NAME}' to '${MACHINE_DIR}${FILE_NAME}'.'
fi
exit 0
