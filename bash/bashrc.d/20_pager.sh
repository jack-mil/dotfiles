# Settings related to pagers and utilities

# set smart-case for `less` search
export LESS="--ignore-case --mouse --quit-if-one-screen \
             --raw-control-chars --tilde --no-histdups"

export LESSHISTFILE="${XDG_STATE_HOME}/less_history"

# Use `nvim` as a manpager
function neovim_man() {
     nvim "+hide Man $*"
}
exists nvim && alias man=neovim_man
