# LS ignore list for Windows
$LS_COMMON = @(
    "NTUSER.DAT*",
    "ntuser.dat*",
    "ntuser.ini",
    "Recent",
    "SendTo",
    "'Start Menu'",
    "'My Documents'",
    "ntuser.pol",
    "NetHood",
    "Cookies",
    "Templates",
    "PrintHood",
    "'Local Settings'"
)

function ls {
    Get-ChildItem -Exclude $LS_COMMON -Path @Args
}

# Eza ignore list for Windows
$IGNORE = @(
    '-I="NTUSER.*|ntuser.*|Recent|SendTo|Start Menu|My Documents|NetHood',
    '-I="Cookies|Templates|PrintHood|Local Settings|Application Data|OneDrive*',
    '-I="|Contacts|Saved Games|Searches"'
)
$EZA_COMMON = @("--no-permissions", "--group-directories-first", "--icons", "--sort=Extension")
function l {
    & eza @EZA_COMMON @IGNORE ${Args}
}

function la {
    & eza -a @EZA_COMMON @IGNORE ${Args}
}

function ll {
    & eza -l -a --header --group @EZA_COMMON @IGNORE ${Args}
}

function lt {
    & eza --tree @args @EZA_COMMON @IGNORE ${Args}
}

function ltl {
    & eza -l --tree --no-time --sort Extension @IGNORE ${Args}
}

function ln-s ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function ln ($target, $link) {
    New-Item -Path $link -ItemType HardLink -Value $target
}

function func_touch {
  $file = $args[0]
  if($file -eq $null) {
    throw "No filename supplied"
  }
  if(Test-Path $file){
    (Get-ChildItem $file).LastWriteTime = Get-Date
  }else{
    echo $null > $file
  }
}

New-Alias -Name "touch" -Value "func_touch"

function which([string]$cmd) {
    Get-Command $cmd -ErrorAction SilentlyContinue -CommandType Application | Format-List Name,Version,Source
}
