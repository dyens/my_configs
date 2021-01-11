export POETRY_ROOT="$HOME/.poetry"
export PYENV_ROOT="$HOME/.pyenv"

export PATH="$POETRY_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

export TERM=xterm

export PATH="$HOME/.poetry/bin:$PATH"


export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64

