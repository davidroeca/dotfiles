include () {
  [[ -f "$1" ]] && source "$1"
}

include ~/.profile
include ~/.bashrc_local
include ~/.bashrc_mint

stty -ixon

############################################################
# Mac OS options
############################################################
if [[ "$(uname -s)" == "Darwin" ]]; then
  NEW_PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  alias ls='ls -G'
  # Add Bash completion
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
else
  NEW_PS1=$PS1
fi
export PS1=$NEW_PS1

############################################################
# Standard alias options
############################################################
alias vn='python3 -m venv venv'
alias va='source venv/bin/activate'

alias tmux='tmux -2'
alias tn='tmux new-session'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'

alias l='ls'
alias ll='ls -l'
alias la='ls -la'

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'
alias .........='cd ../../../../../../../../'
alias ..........='cd ../../../../../../../../../'
alias ...........='cd ../../../../../../../../../../'
alias ............='cd ../../../../../../../../../../../'
alias .............='cd ../../../../../../../../../../../../'
alias ..............='cd ../../../../../../../../../../../../../'
