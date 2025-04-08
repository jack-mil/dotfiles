# Settings related to pagers and utilities

# set smart-case for `less` search
export LESS="--ignore-case --mouse"

# Use `nvim` as a manpager
function neovim_man() {
     nvim "+hide Man $*"
}
[[ -x "$(command -v nvim)" ]] && alias man=neovim_man
