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

export PATH
