# Initialize zoxide directory jumping utility
# replaces the `cd` alias
# https://github.com/ajeetdsouza/zoxide

if exists zoxide; then 
    eval "$(zoxide init --cmd cd bash)"
fi
