# Environment variables to export to child programs

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_VIDEOS_DIR="$HOME/videos"

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# Python
export PIP_REQUIRE_VIRTUALENV=true
export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"

export UV_CACHE_DIR="${XDG_CACHE_HOME}/uv"
# export UV_NO_MANAGED_PYTHON=true
export UV_PYTHON_DOWNLOADS="manual"

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep.rc"

# add local bin in front of path
prepend_path "${XDG_BIN_HOME}"

# source cargo environment
if [ -f "${HOME}/.cargo/env" ]; then
  export BINSTALL_DISABLE_TELEMETRY=true
  source ${HOME}/.cargo/env
fi
