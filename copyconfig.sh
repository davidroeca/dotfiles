#!/bin/bash

# ------------------------------------------------
# Work in progress.
# ------------------------------------------------
# Script used to copy vimrc file to and from
# personal home directory.
#
# Could be scaled later to provide further
# functionality with different home paths and 
# potentially an array of files other than vimrc
# as well.
# ------------------------------------------------

# ------------------------------------------------
# Handle command line args and set env variables
# ------------------------------------------------

MACHINE_WRITE=true
echo $1
if [ "$#" -lt 1 ]
then
    echo 'Not enough args.'
else
    if [ "$1" == '-torepo' ]
    then
        MACHINE_WRITE=false
    elif [ "$1" != '-tohome' ]
    then
        echo 'Bad first flag.'
        exit 0
    fi 
fi
if [ "$#" -ge 2 ]
then
    MACHINE_DIR=$2
else
    MACHINE_DIR='/home/david/'
fi

FILE_NAME='.vimrc'
REPO_DIR=${MACHINE_DIR}'Scripts/myconfig/config_files/'

# ------------------------------------------------
# Function definition 
# ------------------------------------------------

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
            echo 'Please try again.'
        fi
    done
}

# ------------------------------------------------
# Prompt user and write files 
# ------------------------------------------------

if [ $MACHINE_WRITE == false  ] # -o represents overwrite
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
