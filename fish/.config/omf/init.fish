contains $fish_user_paths $HOME/bin; or set -Ua fish_user_paths $HOME/bin
# Set Pure theme variables
set -g pure_show_jobs true
# Set BOB_THE_FISH theme variables
set -g theme_color_scheme gruvbox
set -g theme_nerd_fonts yes

set -g theme_title_display_process yes
set -g theme_title_display_path no

set -g theme_date_timezone America/New_York
set -g theme_date_format "+%l:%M %p"

set -g fish_prompt_pwd_dir_length 8
set -g theme_newline_cursor yes

set -x LESSHISTFILE="/dev/null"
