# Configuration for the fzf utility (https://github.com/junegunn/fzf)
# Provides fuzzy searching and integration with many other utilities
# This sets up environment variables, theming, and bash shell integration
# This configuration assumes installation with the fd utility (github.com/sharkdp/fd)

# don't load this file if fzf not installed
[[ ! -x "$(command -v fzf)" ]] && return

# setup shell-integration
eval "$(fzf --bash)"

# set options
export FZF_CTRL_T_OPTS=" \
  --style=full \
  --input-label ' Find File ' \
  --preview 'bat --color=always --style=plain --line-range :300 {}' \
  --preview-window right,70%"
export FZF_ALT_C_OPTS=" \
  --style=full \
  --input-label ' Change Directory ' \
  --preview 'eza --tree --level 3 --color=always --group-directories-first --icons --sort Extension {} | head -200' \
  --preview-window right,50%"
export FZF_CTRL_R_OPTS=" \
  --style=full \
  --input-label ' Command History [?]:preview' \
  --preview 'echo {}' \
  --preview-window down:3:hidden:wrap \
  --bind '?:toggle-preview'"
# replaces default --walker command
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --exclude .git --exclude node_modules"

FZF_MOVEMENT="--bind='alt-]:preview-page-down' \
              --bind='alt-[:preview-page-up' \
              --bind='alt-p:toggle-preview'"
# Catppuccin colors
# FZF_COLORS=" \
#   --color=bg+:#414559,spinner:#f2d5cf,hl:#a6d189 \
#   --color=fg:#c6d0f5,header:#e78284,info:#85c1dc,pointer:#ef9f76 \
#   --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ef9f76,hl+:#e78284 \
#   --color=selected-bg:#51576d"
  
FZF_COLORS=" \
--color=bg+:#363a4f,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#eed49f,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--color=list-border:#a6da95,list-label:#a6da95:italic \
--color=preview-border:#ed8796,preview-label:#ed8796:italic \
--color=input-border:#c6a0f6,input-label:#c6a0f6:italic \
--color=header-border:#8aadf4,header-label:#8aadf4:italic"

export FZF_DEFAULT_OPTS=" \
  $FZF_MOVEMENT \
  $FZF_COLORS \
  --height=40% \
  --tmux=bottom,40% \
  --border=none \
  --preview-border=rounded \
  --list-border=rounded \
  --header-border=rounded \
  --input-border=rounded \
  --cycle --multi"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
