# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$ZDOTDIR/env.zsh"
source "$ZDOTDIR/theme.zsh"
source "$ZDOTDIR/aliases.zsh"

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/comp_cache

# This clears the screen and add the scrollback to the buffer, to not lose
# history for kitty
scroll-and-clear-screen() {
  printf '\n%.0s' {1..$LINES}
  zle clear-screen
  }
  zle -N scroll-and-clear-screen
  bindkey '^l' scroll-and-clear-screen
# vim:ft=zsh:nowrap
