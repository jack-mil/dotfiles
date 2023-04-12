
_PRE_PS1='\[\033]0;\w\007\]'         # set window title to cwd
_PRE_PS1="$_PRE_PS1"'\n'                  # new line
# _PRE_PS1="$_PRE_PS1"'\[\033[32m\]'      # change to green
# _PRE_PS1="$_PRE_PS1"'\u@\h '            # user@host<space>
# _PRE_PS1="$_PRE_PS1"'\[\033[35m\]'      # change to purple
# _PRE_PS1="$_PRE_PS1"'$MSYSTEM '         # show MSYSTEM
# _PRE_PS1="$_PRE_PS1"'\[\033[33m\]'      # change to brownish yellow
_PRE_PS1="$_PRE_PS1"'\[\033[1;36m\]'        # change color to cyan
# _PRE_PS1="$_PRE_PS1"'${PWD/\/*/}'       # current working directory
# _PRE_PS1="$_PRE_PS1"'\[\033[33m\]'      # change to brownish yellow
_PRE_PS1="$_PRE_PS1"'\w'                  # Full Path
GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
if test -f "$COMPLETION_PATH/git-prompt.sh"
then
    . "$COMPLETION_PATH/git-prompt.sh"
    # _PRE_PS1="$_PRE_PS1"'\[\033[36m\]'  # change color to cyan
    _PRE_PS1="$_PRE_PS1"'\[\033[1;35m\]'       # change to purple
    # PS1="$PS1""$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)"   # bash function
    PROMPT_COMMAND='GIT_PS1_SHOWUPSTREAM="verbose" GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1 __git_ps1 "$_PRE_PS1" "$_POST_PS1" "  %s"'
fi
# _POST_PS1="$_POST_PS1"'\[\033[0m\]'        # change color
_POST_PS1="$_POST_PS1"'\[\033[1;32m\]'       # change to green
_POST_PS1="$_POST_PS1"'\n'                 # new line
_POST_PS1="$_POST_PS1"'❯ '                 # prompt: always $
_POST_PS1="$_POST_PS1"'\[\033[0m\]'        # revert color