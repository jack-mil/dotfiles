#!/usr/bin/env bash
#
# Modification of example script shipped by fzf to suit my needs
# 
# https://github.com/junegunn/fzf/blob/master/bin/fzf-preview.sh
#
# Dependencies:
# - https://github.com/sharkdp/bat
# - kitty terminal with graphics protocol
#
# The MIT License (MIT)
#
# Copyright (c) 2013-2025 Junegunn Choi
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

if [[ $# -ne 1 ]]; then
  >&2 echo "usage: $0 FILENAME[:LINENO][:IGNORED]"
  exit 1
fi

file=${1/#\~\//$HOME/}

# parses line number suffix if provided (e.g. from grep/rg)
center=0
if [[ ! -r $file ]]; then
  if [[ $file =~ ^(.+):([0-9]+)\ *$ ]] && [[ -r ${BASH_REMATCH[1]} ]]; then
    file=${BASH_REMATCH[1]}
    center=${BASH_REMATCH[2]}
  elif [[ $file =~ ^(.+):([0-9]+):[0-9]+\ *$ ]] && [[ -r ${BASH_REMATCH[1]} ]]; then
    file=${BASH_REMATCH[1]}
    center=${BASH_REMATCH[2]}
  fi
fi

type=$(file --brief --dereference --mime -- "$file")

if [[ ! $type =~ image/ ]]; then
  # Display `file` output for binary files
  if [[ $type =~ =binary ]]; then
    file "$1"
    exit
  fi

  # Sometimes bat is installed as batcat.
  if command -v batcat > /dev/null; then
    batname="batcat"
  elif command -v bat > /dev/null; then
    batname="bat"
  else
    cat "$1"
    exit
  fi

  ${batname} --style="${BAT_STYLE:-numbers}" --color=always --pager=never --line-range :300 --highlight-line="${center:-0}" -- "$file"
  exit
fi

dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}
if [[ $dim == x ]]; then
  dim=$(stty size < /dev/tty | awk '{print $2 "x" $1}')
elif ! [[ $KITTY_WINDOW_ID ]] && ((FZF_PREVIEW_TOP + FZF_PREVIEW_LINES == $(stty size < /dev/tty | awk '{print $1}'))); then
  # Avoid scrolling issue when the Sixel image touches the bottom of the screen
  # * https://github.com/junegunn/fzf/issues/2544
  dim=${FZF_PREVIEW_COLUMNS}x$((FZF_PREVIEW_LINES - 1))
fi

# 1. Use icat (from Kitty) if kitten is installed
if [[ $KITTY_WINDOW_ID ]] || [[ $GHOSTTY_RESOURCES_DIR ]] && command -v kitten > /dev/null; then
  # 1. 'memory' is the fastest option but if you want the image to be scrollable,
  #    you have to use 'stream'.
  #
  # 2. The last line of the output is the ANSI reset code without newline.
  #    This confuses fzf and makes it render scroll offset indicator.
  #    So we remove the last line and append the reset code to its previous line.
  kitten icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place="$dim@0x0" "$file" | sed '$d' | sed $'$s/$/\e[m/'

# # 2. Use chafa with Sixel output
# elif command -v chafa > /dev/null; then
#   chafa -s "$dim" "$file"
#   # Add a new line character so that fzf can display multiple images in the preview window
#   echo
#
# # 3. If chafa is not found but imgcat is available, use it on iTerm2
# elif command -v imgcat > /dev/null; then
#   # NOTE: We should use https://iterm2.com/utilities/it2check to check if the
#   # user is running iTerm2. But for the sake of simplicity, we just assume
#   # that's the case here.
#   imgcat -W "${dim%%x*}" -H "${dim##*x}" "$file"

# 4. Cannot find any suitable method to preview the image
else
  file "$file"
fi
