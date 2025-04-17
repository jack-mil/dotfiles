#!/usr/bin/env bash

# Author: jack-mil
# License: BSD Zero Clause (0BSD)

# This can clobber existing files if curl fails
# Only use this on version controlled and check-in file.

DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
theme_dir="${DIR}/themes"
mkdir -p "$theme_dir"

# block comment format for xml
COPEN="<!--"
CCLOSE="-->"

CURLARGS="--silent --show-error --fail --location --proto '=https' --tlsv1.2"

SOURCE="https://github.com/catppuccin/bat"
LICENSE=$(curl $CURLARGS "https://github.com/catppuccin/bat/raw/main/LICENSE")

files=(
    'https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme'
    'https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme'
    'https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme'
    'https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme'
)

# https://github.com/SixArm/urldecode.sh/blob/0b42f15475e64daf0aee9df81b7b42089373550c/urldecode.sh
# modified to decode just the base filename
url_file() {
    # url_file <string>

    local url_encoded="${1//+/ }"
    local file="${url_encoded##*/}"
    printf '%b' "${file//%/\\x}"
}

download_list() {
    local -n list=$1
    local dir=$2
    for url in "${list[@]}"; do
        local filename=$( url_file $url )
        echo "Downloading => $dir/$filename"
        {
            echo "$COPEN"
            echo From: "$SOURCE"
            echo "$LICENSE"
            echo "$CCLOSE"
            curl $CURLARGS "$url"
        } > "${dir}/${filename}"
    done
}

download_list files $theme_dir
