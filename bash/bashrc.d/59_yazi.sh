# Yazi terminal file-browser
# https://yazi-rs.github.io/

[[ ! -x "$(command -v yazi)" ]] && return

export YAZI_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/yazi"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
