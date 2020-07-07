#!/bin/bash

awk '/^[a-z]/ && last {print "<small>",$0,"\t",last,"</small>"} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |
    column -t -s $'\t' |
    rofi -dmenu -i -markup-rows -no-show-icons -width 1000 -lines 15 -yoffset 40

awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}'
