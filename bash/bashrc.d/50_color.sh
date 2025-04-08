# Configure ls colors and other program default color settings

# setup colors for ls/grep/dir...etc
if [[ -x "$(command -v vivid)" ]]; then
    export LS_COLORS="$(vivid generate catppuccin-frappe)"
elif [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export LESS="$LESS --use-color"

# auto color common utilities
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
