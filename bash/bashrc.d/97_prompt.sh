# Starship shell prompt
# https://starship.rs/

if [[ -x "$(command -v starship)" ]]; then
    eval -- "$(starship init bash --print-full-init)"
fi
