# Environment variables to export to child programs

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_VIDEOS_DIR="$HOME/videos"

export EDITOR=nvim
export VISUAL=nvim
export PIP_REQUIRE_VIRTUALENV=true

# add local bin in front of path
prepend_path "$HOME/.local/bin"

# source cargo environment
if [ -f "$HOME/.cargo/env" ]; then
  export BINSTALL_DISABLE_TELEMETRY=true
  source $HOME/.cargo/env
fi
