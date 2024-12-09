#!/bin/bash

# Utility to manage AppImage archives.
# Many (most) AppImages include a icon and a .desktop file
# We just need to extract it and copy to right locations
# Also standardize the naming and storage location of the AppImage
# in .local/bin
# Modified from: https://github.com/un1t/appimage-desktop-entry

set -e
set -o pipefail

APPIMAGE_PATH=$1

if [ -z "$APPIMAGE_PATH" ]; then
    echo "Missing argument: appimage"
    exit 1
fi

if [ ! -f "$APPIMAGE_PATH" ]; then
    echo "File not found: $APPIMAGE_PATH"
    exit 1
fi


APPIMAGE_FULLPATH=$(readlink -e "$APPIMAGE_PATH")
APPIMAGE_FILENAME=$(basename "$APPIMAGE_PATH")
APP_NAME="${APPIMAGE_FILENAME%.*}"    # The appimage might not be named nicely, have some way to change this...
DESKTOP_FOLDER="${HOME}/.local/share/applications"
ICON_FOLDER="${HOME}/.local/share/icons"
BIN_FOLDER="${HOME}/.local/bin"

mkdir -p "${ICON_FOLDER}"
mkdir -p "${DESKTOP_FOLDER}"
mkdir -p "${BIN_FOLDER}"

if [ "$2" == "--remove" ]; then
    rm -f "$DESKTOP_ENTRY_PATH"
    find "${ICON_FOLDER}" -maxdepth 1 -type f -name "$APP_NAME.*" -delete
    echo "Removed"
    exit 0
fi

rm -rf /tmp/squashfs-root/ > /dev/null
cd /tmp/
"$APPIMAGE_FULLPATH" --appimage-extract > /dev/null
cd /tmp/squashfs-root/

echo "Choose icon: "
mapfile -t FILENAMES < <(find -L . -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.svg' \))
i=1
for filename in "${FILENAMES[@]}"
do
    printf " %d) %s\n" "$i" "$filename"
    i=$((i + 1))
done

read -r SELECTED_INDEX

ICON_SRC=${FILENAMES[$((SELECTED_INDEX - 1))]}
ICON_EXT="${ICON_SRC##*.}"
ICON_DST="${ICON_FOLDER}/$APP_NAME.$ICON_EXT"
cp "$ICON_SRC" "$ICON_DST"


echo "Choose .desktop: "
mapfile -t FILENAMES < <(find -L . -maxdepth 1 -type f \( -iname '*.desktop' \))
i=1
for filename in "${FILENAMES[@]}"
do
    printf " %d) %s\n" "$i" "$filename"
    i=$((i + 1))
done

read -r SELECTED_INDEX

DESKTOP_SRC=${FILENAMES[$((SELECTED_INDEX - 1))]}
DESKTOP_EXT="${DESKTOP_SRC##*.}"
DESKTOP_DST="${DESKTOP_FOLDER}/$APP_NAME.$DESKTOP_EXT"
cp "$DESKTOP_SRC" "$DESKTOP_DST"

sed -i "s|^Exec=.*|Exec=$APPIMAGE_FULLPATH|g" ${DESKTOP_DST}
sed -i "s|^Icon=.*|Icon=$APP_NAME|g" ${DESKTOP_DST}

xdg-desktop-menu forceupdate

echo "Created"
