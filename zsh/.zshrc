# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jackmil/.zsh/oh-my-zsh"

ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-rpi4"
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_hist"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugin Configuration
plugins=(colored-man-pages zsh-interactive-cd gitignore fancy-ctrl-z z fz)

 _Z_DATA="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/z"

 # Load plugins and defaults
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable suggests and syntax highlighting
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User config:

# Enviroment stuff
export EDITOR=nvim
export BAT_THEME="Monokai Extended"
unset LESS # OMZ be dumb

# Configuration aliases
alias ec="$EDITOR $HOME/.zshrc"
alias reload="exec zsh"

# ls files with exa
alias l="exa -h --icons --color-scale --group-directories-first"
alias la="exa -ahF --icons --color-scale --group-directories-first"
alias ll="exa -lhF --git --icons --color-scale --group-directories-first"

# Useful defaults
alias rm="rm -I"
alias py="python3"

# Open some files with vim
alias -s md=$EDITOR
