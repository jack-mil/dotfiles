#!/usr/bin/env bash

# Copyright (c) 2024-2025 jack-mil
# License: MIT

# Be careful; don't use this blindly. Check changes with git after downloading
# Execute in the dotfiles repo, not in mpv config directory

# Optionally download https://github.com/tsl0922/mpv-debug-plugin,
# not including it here because it is binary

DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

scripts_dir="$DIR/scripts"
shaders_dir="$DIR/shaders"

mkdir -p "$scripts_dir"
mkdir -p "$shaders_dir"

scripts=(
	'https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autocrop.lua'
	'https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua'
	'https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua'
	'https://raw.githubusercontent.com/occivink/mpv-scripts/master/scripts/seek-to.lua'
	'https://raw.githubusercontent.com/occivink/mpv-scripts/master/scripts/misc.lua'
	'https://raw.githubusercontent.com/occivink/mpv-scripts/master/scripts/blur-edges.lua'
	'https://raw.githubusercontent.com/Dudemanguy/mpv-manga-reader/master/manga-reader.lua'
	'https://raw.githubusercontent.com/dyphire/mpv-scripts/main/open_dialog.lua'
	#'https://raw.githubusercontent.com/po5/trackselect/master/trackselect.lua'
)

# https://github.com/bjin/mpv-prescalers/
# https://github.com/Artoriuz/ArtCNN
shaders=(
	'https://raw.githubusercontent.com/bjin/mpv-prescalers/master/compute/nnedi3-nns128-win8x4.hook'
	'https://raw.githubusercontent.com/Artoriuz/ArtCNN/refs/heads/main/GLSL/ArtCNN_C4F32.glsl'
	'https://raw.githubusercontent.com/Artoriuz/ArtCNN/refs/heads/main/GLSL/ArtCNN_C4F32_DS.glsl'
)

function download_list { # args: 1=list of links 2=output directory
	local -n list=$1
	local dir=$2
	for url in "${list[@]}"; do
		local filename="${url##*/}"
		echo "Downloading => $filename"
		curl --silent --show-error --fail -L "$url" -o "${dir}/${filename}"
	done
}

download_list scripts "$scripts_dir"
download_list shaders "$shaders_dir"

echo "Updating Finished"
