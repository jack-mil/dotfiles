# Swap the first and the second argument of the last command
alias oops-swap='$(history -p !:0 !:2 !:1)'

alias mv='mv -vi'
alias cp='cp -vr'
alias rm='rm -vi'
alias del='trash-put'

alias ls='ls -F --color=auto'
alias l='exa --icons --group-directories-first'
alias ll='exa -l --git --header --icons --group-directories-first'
alias la='exa -a --icons --group-directories-first'
alias lt='exa --icons --tree'

alias grep='grep --color=auto'

alias cat="bat --color always --plain"

alias icat='kitty +kitten icat'
alias copy='xclip <'
alias fd='fd --one-file-system'
alias rg='rg --one-file-system'

alias pactree='pactree --color'
