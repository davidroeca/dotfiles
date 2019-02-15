if [ -z $DR_PROFILE_SOURCED ]
then
  # profile hasn't been sourced; prevent this from happening twice
  export DR_PROFILE_SOURCED='1'
else
  # a second call to "source" just exits
  return
fi


path_ladd() {
  # Takes 1 argument and adds it to the beginning of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

path_radd() {
  # Takes 1 argument and adds it to the end of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

############################################################
# Define preferred editor
############################################################
if [ -x "$(command -v nvim)" ]
then
  export EDITOR=nvim
elif [ -x "$(command -v vim)" ]
then
  export EDITOR=vim
else
  export EDITOR=vi
fi

############################################################
# Set React environment variables
############################################################
export REACT_EDITOR='vim'

############################################################
# Modify path
############################################################

PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]
then
  export PYENV_ROOT
  path_radd "$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
fi

NODENV_ROOT="$HOME/.nodenv"
if [ -d "$NODENV_ROOT" ]
then
  export NODENV_ROOT
  path_radd "$NODENV_ROOT/bin"
  eval "$(nodenv init -)"
fi

GOENV_ROOT="$HOME/.goenv"
if [ -d "$GOENV_ROOT" ]
then
  export GOENV_ROOT
  path_radd "$GOENV_ROOT/bin"
  eval "$(goenv init -)"
fi

SDKMAN_DIR="$HOME/.sdkman"
if [ -d "$SDKMAN_DIR" ]
then
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && \
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

TFENV_ROOT="$HOME/.tfenv"
if [ -d "$TFENV_ROOT" ]
then
  export TFENV_ROOT
  path_radd "$TFENV_ROOT/bin"
fi


POETRY_PATH="$HOME/.poetry/bin"
if [ -d "$POETRY_PATH" ]
then
  path_radd $POETRY_PATH
fi

path_ladd "$HOME/.cargo/bin"
path_ladd "$HOME/bin" # Personal binary files

GOPATH="$HOME/go"
if [ -d $GOPATH ]
then
  export GOPATH
fi

ZPLUG_HOME="$HOME/.zplug"
if [ -d $ZPLUG_HOME ]
then
  export ZPLUG_HOME
fi

export PATH
