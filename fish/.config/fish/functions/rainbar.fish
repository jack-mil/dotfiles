function rainbar --description "display a random rainbow sparkine"
    echo 
    seq 1 (tput cols) | sort -R | spark | lolcat
    echo
end

