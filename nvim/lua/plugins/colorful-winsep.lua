-- Animate and color the window splits to highlight current window
-- Colors set by Catppuccin integration
-- https://github.com/nvim-zh/colorful-winsep.nvim
return {
  'nvim-zh/colorful-winsep.nvim',
  event = { 'WinLeave' },
  config = true,
  opts = {
    only_line_seq = false, -- highlight top if left window selected
  },
}
