#
# Use exa instead of ls
#
function la --wraps exa --description "List contents of directory, including hidden files in directory using short format (exa)"
    exa -aFh --icons --color-scale --group-directories-first $argv
end

