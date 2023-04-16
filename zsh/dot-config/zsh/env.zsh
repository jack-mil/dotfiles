# # Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-arch"
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_hist"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"