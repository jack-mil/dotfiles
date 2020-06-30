# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jackmil/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/local/powerlevel10k/powerlevel10k.zsh-theme

# User config:
#
# Enviroment stuff

export EDITOR=nvim
export BAT_THEME="Monokai Extended"

# Configuration aliases
alias ec="$EDITOR $HOME/.zshrc"
alias sc="source $HOME/.zshrc"

# ls files with exa
alias l="exa -h --icons --color-scale --group-directories-first"
alias la="exa -ahF --icons --color-scale --group-directories-first"
alias ll="exa -lhF --git --icons --color-scale --group-directories-first"

# Useful defaults
alias rm="rm -I"
alias py="python3"

# Open some files with vim
alias -s md=$EDITOR

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
