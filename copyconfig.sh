#!/bin/bash

# ------------------------------------------------
# Work in progress.
# ------------------------------------------------
# Script used to copy vimrc file to and from
# personal home directory.
# ------------------------------------------------

# ------------------------------------------------
# Handle command line args and set env variables
# ------------------------------------------------

# General argument structure: [SCRIPTS_DIR [HOME_DIR]]

if [ "$#" -ge 2 ]
then
    HOME_DIR=$2
else
    HOME_DIR=$HOME/
fi
if [ "$#" -ge 1 ]
then
    SCRIPTS_DIR=${HOME_DIR}$1
else
    SCRIPTS_DIR=${HOME_DIR}'Scripts/'
fi

FILE_NAME='.vimrc'
REPO_DIR=${SCRIPTS_DIR}'myconfig/config_files/'

SOURCE=${REPO_DIR}${FILE_NAME}
DESTINATION=${HOME_DIR}${FILE_NAME}

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

# handle case where we want to write to the repo
echo 'Create symbolic link of '${SOURCE}' to '${DESTINATION}'?'
echo '(Run <ln -s '${SOURCE} ${DESTINATION}'>)'
confirm
if [ -e ${DESTINATION} ]
then
    echo ${DESTINATION} 'exists. Delete?'
    echo '(Run <rm ${DESTINATION}>)'
    confirm
    rm ${DESTINATION}
fi
ln -s ${SOURCE} ${DESTINATION}
echo 'Created symbolic link of '${SOURCE}' to '${DESTINATION}'.'
exit 0
