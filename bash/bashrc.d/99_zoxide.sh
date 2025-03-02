# Initialize zoxide directory jumping utility
# replaces the `cd` alias
# https://github.com/ajeetdsouza/zoxide

[[ -x "$(command -v zoxide)" ]] && eval "$(zoxide init --cmd cd bash)"
