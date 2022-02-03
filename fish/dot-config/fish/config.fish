if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx GPG_TTY (tty)

    #ABBREVIATIONS
    abbr --add --global gco git checkout
    abbr --add --global gcm git commit -m
    abbr --add --global gst git status

    # ALIASES
    alias rm "rm -I"
    alias l "exa -h --icons --color-scale --group-directories-first"
    alias la "exa -aFh --icons --color-scale --group-directories-first"
    alias ll "exa -lhF --git --icons --color-scale --group-directories-first"
    alias icat "kitty +kitten icat"
end
