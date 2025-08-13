-- Animate and color the window splits to highlight current window
-- Colors set by Catppuccin integration
-- https://github.com/nvim-zh/colorful-winsep.nvim
return {
  'nvim-zh/colorful-winsep.nvim',
  branch = 'main',
  event = { 'WinLeave' },
  config = true,
  opts = {
    border = "single",
    animate = { enabled = false },
  },
}
