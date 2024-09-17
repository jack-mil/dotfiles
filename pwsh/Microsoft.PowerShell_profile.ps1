
$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

$env:PIP_REQUIRE_VIRTUALENV = "true"
$env:YAZI_FILE_ONE = "$env:USERPROFILE\scoop\apps\git\current\usr\bin\file.exe"
$env:YAZI_CONFIG_HOME = "$env:USERPROFILE\.config\yazi"

# Source aliases
$profileDir = Split-Path -Parent $PROFILE
if (Test-Path "$profileDir\aliases.ps1") {
    . "$profileDir\aliases.ps1"
}

# Z-like traversal
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

# Prompt
Invoke-Expression (&starship init powershell)
