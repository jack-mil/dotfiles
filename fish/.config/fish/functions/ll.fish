#
# Use exa instead of ls
#
function ll --wraps exa --description "List contents of directory using long format (exa)"
    exa -lhF --git --icons --color-scale --group-directories-first $argv
end
