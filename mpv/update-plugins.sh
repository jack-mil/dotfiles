#!/usr/bin/env bash

# Optionally download https://github.com/tsl0922/mpv-debug-plugin,
# not including it here because it is binary

scripts_dir="./scripts/"
shaders_dir="./shaders/"

scripts=(
	"https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autocrop.lua"
	"https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua"
	"https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua"
	"https://raw.githubusercontent.com/occivink/mpv-scripts/master/scripts/seek-to.lua"
	"https://raw.githubusercontent.com/occivink/mpv-scripts/master/scripts/misc.lua"
	"https://raw.githubusercontent.com/occivink/mpv-scripts/master/scripts/blur-edges.lua"
	"https://raw.githubusercontent.com/occivink/mpv-scripts/master/scripts/crop.lua"
	"https://raw.githubusercontent.com/Dudemanguy/mpv-manga-reader/master/manga-reader.lua"
	#"https://raw.githubusercontent.com/po5/trackselect/master/trackselect.lua"
)

shaders=(
	"https://raw.githubusercontent.com/bjin/mpv-prescalers/master/compute/nnedi3-nns128-win8x4.hook"
	"https://raw.githubusercontent.com/Artoriuz/ArtCNN/main/ArtCNN_C4F32.glsl"
)

mkdir -p $scripts_dir
mkdir -p $shaders_dir

for url in "${scripts[@]}"; do
	filename=$(basename $url)
	curl -L $url -o $scripts_dir$filename
done

for url in "${shaders[@]}"; do
	filename=$(basename $url)
	curl -L $url -o $shaders_dir$filename
done

echo "Updating Finished"