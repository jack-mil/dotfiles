-- https://github.com/yazi-rs/plugins/tree/main/full-border.yazi
require('full-border'):setup({
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = ui.Border.ROUNDED,
})

-- In neovim, hide preview when opened
-- https://github.com/yazi-rs/plugins/tree/main/toggle-pane.yazi
if os.getenv('NVIM') then require('toggle-pane'):entry('min-preview') end

-- https://yazi-rs.github.io/docs/tips#symlink-in-status
Status:children_add(function(self)
  local h = self._current.hovered
  if h and h.link_to then
    return ' -> ' .. tostring(h.link_to)
  else
    return ''
  end
end, 3300, Status.LEFT)

-- https://yazi-rs.github.io/docs/tips#user-group-in-status
Status:children_add(function(self)
	local h = self._current.hovered
	if h == nil or ya.target_family() ~= "unix" then -- linux only
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	}
end, 500, Status.RIGHT)
