# Configuration for the fzf utility (https://github.com/junegunn/fzf)
# Provides fuzzy searching and integration with many other utilities
# This sets up environment variables, theming, and bash shell integration
# This configuration assumes installation with the fd utility (github.com/sharkdp/fd)

# don't load this file if fzf not installed
! exists fzf && return

# setup shell-integration
eval "$(fzf --bash)"

# set options
export FZF_CTRL_T_OPTS=" \
  --ghost 'Pick File' \
  --prompt '╰❯ ' \
  --preview 'bat --color=always --style=plain --line-range :300 {}' \
  --preview-window right,60%"

export FZF_ALT_C_OPTS=" \
  --ghost 'Change Directory' \
  --preview 'eza --tree --level 3 --color=always --group-directories-first --icons --sort Extension {} | head -200' \
  --preview-window right,60%"

export FZF_CTRL_R_OPTS="\
  --input-border=rounded \
  --input-label ' Command History [A-p]:preview ' \
  --preview 'echo {2..} | bat --style=plain --color=always --language=sh' \
  --preview-window down:3:hidden:wrap"

# replaces default --walker command
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --exclude .git --exclude node_modules --exclude '.*cache*'"

FZF_BINDS="--bind='alt-d:preview-page-down' \
           --bind='alt-u:preview-page-up' \
           --bind='alt-p:toggle-preview' \
           --bind='alt-r:toggle-raw' \
           --bind='result:best'"  # move cursor to item with best score (for raw mode)

FZF_COLORS="--color='
fg:#cad3f5,current-fg:#cad3f5,
bg:-1,current-bg:#363a4f,alt-bg:#1e2030,
hl:#a6da95,current-hl:#eed49f,
selected-fg:#b8c0e0,selected-bg:#494d64,selected-hl:#8bd5ca,marker:#8bd5ca,
spinner:#f4dbd6,prompt:#c6a0f6,pointer:#f4dbd6,
header:#ed8796,info:#f5a97f,
list-border:#a6da95,list-label:#a6da95:italic,
preview-border:#ed8796,preview-label:#ed8796:italic,
input-border:#c6a0f6,input-label:#c6a0f6:italic,
header-border:#8aadf4,header-label:#8aadf4:italic,
nomatch:dim:strip'"

export FZF_DEFAULT_OPTS=" \
  $FZF_BINDS \
  $FZF_COLORS \
  --prompt='❯ ' \
  --height=60% \
  --tmux=bottom,40% \
  --border=none \
  --cycle \
  --multi"
  # --preview-border=rounded \
  # --list-border=rounded \
  # --header-border=rounded \
  # --input-border=rounded \

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

# Redefine this function from https://github.com/junegunn/fzf-git.sh
# to customize the appearance. Their script will use this function if defined
_fzf_git_fzf() {
  fzf --height 80% --tmux 90%,70% \
    --layout reverse --multi --min-height 20+ \
    --info=inline-right \
    --no-separator --header-border horizontal \
    --preview-window 'right,50%' --preview-border line \
    --bind 'ctrl-/:change-preview-window(down,50%|hidden|)' "$@"
}
