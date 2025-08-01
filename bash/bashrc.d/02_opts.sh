# Settings related to bash runtime options and history functionality

HISTFILE="${XDG_STATE_HOME}/bash_history"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=10000000
HISTIGNORE='bg:fg:history'

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
# stop fat-fingering CTRL-D
shopt -s -o ignoreeof
# limits recursive functions, see 'man bash'
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100   
