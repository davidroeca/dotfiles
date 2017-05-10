#!/bin/bash
DIR=$(realpath $(dirname $0))
SOURCE_PATH="$DIR/anacron"
DESTINATION_PATH="$HOME/.anacron"
if [ -e $DESTINATION_PATH ] || [ -L $DESTINATION_PATH ]
then
  echo "${DESTINATION_PATH} already exists; please move it safely or delete it"
else
  ln -s $SOURCE_PATH $DESTINATION_PATH
fi
