# Command and convenience aliases for bash interactive sessions

# Move up quickly
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# always display diff when deploying dotfiles
alias dotter='dotter -v'

# weird hack to use sudo with aliases...
alias sudo='sudo '

# interactive if lots of files deleted
alias rm='rm -vI'
alias del='trash-put'

# Aliases for bat
alias b='bat'
alias bh='bat --plain --language=cmd-help'  # meant for piping <cmd> --help output to
help() (
    set -o pipefail
    "$@" --help 2>&1 | bh
)
# replace cat with plain bat
[[ -x "$(command -v bat)" ]] && alias cat='bat --color always --plain'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Use `nvim` as a manpager
function neovim_man() {
     nvim "+hide Man $*"
}
[[ -x "$(command -v nvim)" ]] && alias man=neovim_man

# configure default ls (and eza) arguments
LS_COMMON="-hGF --color=auto"

{{#if (eq dotter.os "windows")}}
# LS ignore list for Windows
LS_COMMON=$LS_COMMON" -I NTUSER.DAT\* -I ntuser.dat\*"
LS_COMMON=$LS_COMMON" -I ntuser.ini -I Recent -I SendTo -I \"Start Menu\" -I \"My Documents\""
LS_COMMON=$LS_COMMON" -I ntuser.pol -I NetHood -I Cookies -I Templates -I PrintHood -I Local\ Settings"
{{/if}}

alias ls="command ls $LS_COMMON"

{{#if (is_executable "eza")}}
# use eza for file listing if available
  {{#if (eq dotter.os "windows")}}
# Eza ignore list for windows
IGNORE='--no-permissions -I "NTUSER.*|ntuser.*|Recent|SendTo|Start Menu|My Documents|NetHood|Cookies|Templates|PrintHood|Local Settings|Application Data|OneDrive*|Contacts|Saved Games|Searches"'
  {{/if}}
EZA_COMMON="--group-directories-first --icons --sort Extension"
alias l="eza $EZA_COMMON $IGNORE"
alias la="eza -a $EZA_COMMON $IGNORE"
alias ll="eza -l -a --links --header --group $EZA_COMMON $IGNORE"
alias lt="eza --tree $EZA_COMMON $IGNORE"
alias ltl="eza -l --links --tree --header --no-time --group --sort Extension $IGNORE"
{{/if}}

# Docker shortcuts
alias dc='docker compose'
alias dcup='docker compose up'
alias dcupd='docker compose up -d'
alias dcupf='docker compose up -d --force-recreate'
alias dcd='docker compose down'
alias dcl='docker compose logs'
alias dclf='docker compose logs -f'
alias dcstop='docker compose stop'
alias dcstart='docker compose start'

# utility function to unarchive anything
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1     ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1     ;;
             *.rar)       rar x $1       ;;
             *.gz)        gunzip $1      ;;
             *.tar)       tar xf $1      ;;
             *.tbz2)      tar xjf $1     ;;
             *.tgz)       tar xzf $1     ;;
             *.zip)       unzip $1       ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# utility for home-lab machine management
alias fixperms='chmod a=,a+rX,u+w,g+w'
alias hgit='GIT_DIR=$HOME/.home GIT_WORK_TREE=$HOME git'

# Utilities for working with media files and ffmpeg
# -------------------------------------------------
function webm2gif() {
    ffmpeg -y -i "$1" -vf palettegen _tmp_palette.png
    ffmpeg -y -i "$1" -i _tmp_palette.png -filter_complex paletteuse -r 10  "${1%.webm}.gif"
    rm _tmp_palette.png
}
function mkgif() {
  ffmpeg.exe -y -i "$1" -filter_complex "[0:v]fps=10,scale=w=-1:h=540:flags=lanczos,split[s0][s1];[s0]palettegen=stats_mode=single[p];[s1][p]paletteuse=new=1:dither=sierra2_4a" -r 10 "${2:-${1%.*}.gif}"
}

function mkgifski() {
  ffmpeg -i "$1" -f yuv4mpegpipe - | gifski.exe --fps=${FPS:=${2:-10}} --height=${H:=${3:-540}} --quality=${Q:=${4:-80}} -o "${1%.*}-r${FPS}-h${H}-q${Q}.gif" -
}
alias ytdlp="yt-dlp --remux-video mkv --no-continue --no-cache-dir --add-metadata --all-subs --embed-subs --embed-thumbnail"
