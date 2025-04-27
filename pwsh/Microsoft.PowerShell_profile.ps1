$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
$env:XDG_CACHE_HOME  = "$env:USERPROFILE\.cache"
$env:XDG_STATE_HOME  = "$env:USERPROFILE\.local\state"
$env:XDG_DATA_HOME   = "$env:USERPROFILE\.local\share"
$env:XDG_BIN_HOME    = "$env:USERPROFILE\.local\bin"

$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

$env:PIP_REQUIRE_VIRTUALENV = "true"
$env:UV_CACHE_DIR = "$env:XDG_CACHE_HOME\uv"
$env:UV_NO_MANAGED_PYTHON = $true
$env:UV_PYTHON_DOWNLOADS = "never"

$env:YAZI_FILE_ONE = "$env:USERPROFILE\scoop\apps\git\current\usr\bin\file.exe"
$env:YAZI_CONFIG_HOME = "$env:XDG_CONFIG_HOME\yazi"

# Source aliases
$profileDir = Split-Path -Parent $PROFILE
if (Test-Path "$profileDir\aliases.ps1") {
    . "$profileDir\aliases.ps1"
}

# Colors for eza
$env:LS_COLORS = "$(vivid generate catppuccin-frappe)"

# Z-like traversal
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

# Prompt
Invoke-Expression (&starship init powershell)
