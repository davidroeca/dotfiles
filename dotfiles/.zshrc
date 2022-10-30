#############################################################
# David's zshrc file |
#---------------------
# {{{ powerlevel10k-specific initialization
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}
# Edit paths {{{
path_ladd () {
  # Takes 1 argument and adds it to the beginning of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

path_radd () {
  # Takes 1 argument and adds it to the end of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

############################################################
# Define preferred editor
############################################################
# TODO: use nvim for pager at some point
export MANPAGER=less
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
export REACT_EDITOR=$EDITOR

############################################################
# Modify path
############################################################

POETRY_PATH="$HOME/.poetry/bin"
if [ -d "$POETRY_PATH" ]
then
  path_radd $POETRY_PATH
fi


CARGO_BIN="$HOME/.cargo/bin"
if [ -d "$CARGO_BIN" ]
then
  path_ladd "$CARGO_BIN"
fi

HOME_LOCAL_BIN="$HOME/.local/bin"
if [ ! -d "$HOME_LOCAL_BIN" ]; then
  mkdir -p "$HOME_LOCAL_BIN"
fi
path_ladd "$HOME_LOCAL_BIN"

HOME_BIN="$HOME/bin"
if [ -d "$HOME_BIN" ]
then
  path_ladd "$HOME_BIN" # Personal binary files
fi

GOPATH="$HOME/go"
if [ -d $GOPATH ]
then
  export GOPATH
fi

export PATH

# }}}
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
include ~/.bash/sensitive
# }}}
# Custom aliases/sources {{{

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

function pythonglobal-install() {
  local packages=(
    black
    cookiecutter
    docker-compose
    isort
    jedi-language-server
    mypy
    pre-commit
    pylint
    restview
  )
  if command -v pipx > /dev/null; then
    for package in $packages; do
      pipx install --force "$package"
    done
  else
    echo 'pipx not installed. Install with "pip install pipx"'
  fi
}

function pipx-clean() {
  if command -v pipx > /dev/null; then
    pipx uninstall-all
  else
    echo 'pipx not installed. Install with "pip install pipx"'
  fi
}

function pythondev-install() {
  local packages=(
    pip
    neovim-remote
    pynvim
  )
  pip install -U $packages
  asdf reshim python
}

function python-change-version() {
  local version=$1
  if [ -z $version ]; then
    echo "Please pass a python version"
  else
    asdf install python $version
    if [ $? != "0" ]; then
      echo $result_status
      echo "something went wrong"
    else
      pipx-clean
      asdf global python $version
      pip install pipx
      asdf reshim python
      pythondev-install
      pythonglobal-install
    fi
  fi
}

function nodeglobal-install() {
  local packages=(
    npm
    neovim
    devspace
    prettier
    svelte-language-server
    tree-sitter-cli
    typescript
    eslint
    degit
  )
  npm install --no-save -g $packages
  asdf reshim nodejs
}


function nvim-update() {
  asdf uninstall neovim nightly
  asdf install neovim nightly
  asdf global neovim nightly
  nvim -c 'UpdateAll'
}


function ve() {
  local venv_name=.venv
  if [ -z "$1" ]; then
    local python_name='python3'
  else
    local python_name="$1"
  fi
  if [ ! -d "$venv_name" ]; then
    $python_name -m venv "$venv_name"
    if [ $? -ne 0 ]; then
      local error_code=$?
      echo "Failed to create virtualenv"
      return error_code
    fi
    source "$venv_name/bin/activate"
    pythondev-install
    deactivate
  else
    echo "$venv_name already exists. Activating."
  fi
  source "$venv_name/bin/activate"
}

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias f='nvim'


alias tmux='tmux -2'
alias tn='tmux new-session \; rename-window "Source Code"'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'

alias -g ...='../../'
alias -g ....='../../../'
alias -g .....'../../../../'
alias -g ......'../../../../../'
alias -g .......'../../../../../../'
alias -g ........'../../../../../../../'
alias -g .........'../../../../../../../../'

# }}}
# Custom external completions {{{
if [ -d ~/.zfunc ]
then
  fpath+=~/.zfunc
fi
# }}}
# custom completions {{{

# Python compiled files
zstyle ":completion:*" ignored-patterns "(*/)#(__pycache__|*.pyc|node_modules|.git)"

# }}}
# Run compinit {{{
autoload -Uz compinit
compinit
# }}}
# {{{ Customize powerlevel10k
include ~/.p10k.zsh
# }}}
# plugins {{{
ZINIT_HOME="$HOME/.zinit"

if [ -f "$ZINIT_HOME/zinit.zsh" ]
then
  source "${ZINIT_HOME}/zinit.zsh"
  zinit snippet OMZ::lib/clipboard.zsh
  # Handle completion from oh-my-zsh
  zinit snippet OMZ::lib/completion.zsh
  # Hitting up arrow key gives most recent hist command
  zinit snippet OMZ::lib/key-bindings.zsh
  zinit snippet OMZ::lib/history.zsh
  zinit light mafredri/zsh-async
  zinit ice depth"1"
  zinit light romkatv/powerlevel10k
  zinit light zsh-users/zsh-syntax-highlighting
else
  echo "------------------------------------------------------------"
  echo "Please install zinit with the following command:"
  echo ""
  echo "git clone https://github.com/zdharma-continuum/zinit ${ZINIT_HOME}"
  echo "------------------------------------------------------------"
fi

# }}}
# asdf includes {{{
include ~/.asdf/asdf.sh
include ~/.asdf/completions/asdf.bash
include ~/.config/asdf-direnv/zshrc
# }}}
