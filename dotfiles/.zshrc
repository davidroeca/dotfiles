#############################################################
# David's zshrc file |
#---------------------
# zsh cache directory {{{
ZSH_CACHE_DIR=$HOME/.zsh_cache
if [ ! -e "$ZSH_CACHE_DIR" ]; then
  mkdir $ZSH_CACHE_DIR
fi
# }}}
# Turn off zsh corrections {{{
DISABLE_CORRECTION="true"
unsetopt correct
unsetopt correct_all

# }}}
# Miscellaneous {{{
# recognizes comments in shell
setopt interactivecomments
# if you type dir name and it's not a command, cd to the dir
setopt auto_cd
# }}}
# plugins {{{
export ZPLUG_HOME="$HOME/.zplug"
if [ -f $ZPLUG_HOME/init.zsh ]
then
  source $ZPLUG_HOME/init.zsh
  zplug "lib/clipboard", from:oh-my-zsh
  # Handle completion from oh-my-zsh
  zplug "lib/completion", from:oh-my-zsh
  # Hitting up arrow key gives most recent hist command
  zplug "lib/key-bindings", from:oh-my-zsh
  zplug "lib/history", from:oh-my-zsh
  zplug "mafredri/zsh-async", from:github
  zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
  if zplug check || zplug install
  then
    zplug load
  fi
fi

# }}}
# History settings {{{
setopt append_history
# }}}
# ls settings {{{
if [[ "$OSTYPE" == darwin* ]]
then
  # This should work fine for OSX
  ls -G . &>/dev/null && alias ls='ls -G'
else
  if [[ -z "$LS_COLORS" ]]
  then
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
  fi
  ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G &>/dev/null && alias ls='ls -G' }
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi
# }}}
# Custom sourcing {{{
include () {
  [[ -f "$1" ]] && source "$1"
}
include ~/.shrc_local
# }}}
# Custom aliases/sources {{{

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias vim='nvim'

alias vn='python3 -m venv venv'
alias va='source venv/bin/activate'

alias tmux='tmux -2'
alias tn='tmux new-session \; rename-window "Source Code"'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'

alias -g ...='../../'
alias -g ....='../../'
alias -g .....='../../../../'
alias -g ......='../../../../../'
alias -g .......='../../../../../../'
alias -g ........='../../../../../../../'
alias -g .........='../../../../../../../../'

# }}}
# Custom completions {{{
if [ -d ~/.zfunc ]
then
  fpath+=~/.zfunc
fi
# }}}
# Run compinit {{{
compinit
# }}}
