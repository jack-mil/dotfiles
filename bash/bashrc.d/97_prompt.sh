# Starship shell prompt
# https://starship.rs/

if exists starship; then
    eval -- "$(starship init bash --print-full-init)"
fi
