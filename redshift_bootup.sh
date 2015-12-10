#!/bin/bash
# Requires redshift, redshift-gtk, and tmux
SESH_NAME="redshift_on_and_off_unique"
if [ $# -gt 0 ] && [ ${1} == '-s' ]
then
    tmux kill-session -t ${SESH_NAME}
    tmux new -d -s ${SESH_NAME} 'redshift-gtk'
    tmux detach -s ${SESH_NAME}
    echo 'started redshift'
fi
if [ $# -gt 0 ] && [ ${1} == '-k' ]
then
    tmux kill-session -t ${SESH_NAME}
    tmux new -d -s ${SESH_NAME} 'redshift -O 6500'
    tmux detach -s ${SESH_NAME}
    echo 'killed redshift'
fi
