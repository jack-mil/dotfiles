# This function is typically bound to Alt-L, it is used to list the contents
# of the directory under the cursor.

function __fish_list_current_token -d "List contents of token under the cursor if it is a directory, otherwise list the contents of the current directory"
    # Detect if exa exists and use in instead of ls
    if type -fq exa
        set prg exa -aF --icons --group-directories-first
    else
        set prg ls -AF
    end
    set val (eval echo (commandline -t))
    printf "\n"
    if test -d $val
        $prg $val
    else
        set dir (dirname $val)
        if test $dir != . -a -d $dir
            $prg $dir
        else
            $prg
        end
    end

    set -l line_count (count (fish_prompt))
    if test $line_count -gt 1
        for x in (seq 2 $line_count)
            printf "\n"
        end
    end

    commandline -f repaint
end
