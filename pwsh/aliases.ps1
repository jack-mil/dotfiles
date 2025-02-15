# LS ignore list for Windows
$LS_COMMON = @(
    "-I NTUSER.DAT*",
    "-I ntuser.dat*",
    "-I ntuser.ini",
    "-I Recent",
    "-I SendTo",
    "-I 'Start Menu'",
    "-I 'My Documents'",
    "-I ntuser.pol",
    "-I NetHood",
    "-I Cookies",
    "-I Templates",
    "-I PrintHood",
    "-I 'Local Settings'"
)

function ls {
    param (
        [string[]]$args
    )
    & ls @args $LS_COMMON
}

# Eza ignore list for Windows
$IGNORE = @(
    '-I="NTUSER.*|ntuser.*|Recent|SendTo|Start Menu|My Documents|NetHood',
    '-I="Cookies|Templates|PrintHood|Local Settings|Application Data|OneDrive*',
    '-I="|Contacts|Saved Games|Searches"'
)
$EZA_COMMON = @("--no-permissions", "--group-directories-first", "--icons", "--sort=Extension")
function l {
    param (
        [string[]]$args
    )
    & eza @args @EZA_COMMON @IGNORE
}

function la {
    param (
        [string[]]$args
    )
    & eza -a @args @EZA_COMMON @IGNORE
}

function ll {
    param (
        [string[]]$args
    )
    & eza -l -a --header --group @args @EZA_COMMON @IGNORE
}

function lt {
    param (
        [string[]]$args
    )
    & eza --tree @args @EZA_COMMON @IGNORE
}

function ltl {
    param (
        [string[]]$args
    )
    & eza -l --tree --no-time --sort Extension @args @IGNORE
}

function ln-s ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function ln ($target, $link) {
    New-Item -Path $link -ItemType HardLink -Value $target
}
