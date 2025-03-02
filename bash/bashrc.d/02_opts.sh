# Settings related to bash runtime options and history functionality

mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"/bash
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}"/bash/history

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=10000
# append to the history file, don't overwrite it
shopt -s histappend
# correct minor spelling (case) when using cd
shopt -s cdspell
# expand paths when using tab completion
shopt -s direxpand
# prevent exit when background jobs running, list them
shopt -s checkjobs
# preview history shortcut commands before running
shopt -s histverify
# limits recursive functions, see 'man bash'
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100   
