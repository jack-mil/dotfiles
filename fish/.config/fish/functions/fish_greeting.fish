# Defined in /home/jackmil/.local/share/omf/themes/bobthefish/fish_greeting.fish @ line 1
function fish_greeting --description What\'s\ up,\ fish\?

    rainbar
    # uname with cow
    uname -nmsr | cowsay | lolcat -r

    # Display uptime
    set_color $fish_color_autosuggestion
    command -sq uptime; and command uptime
    set_color normal

end
