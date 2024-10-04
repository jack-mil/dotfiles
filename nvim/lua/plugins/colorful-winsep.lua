-- Animate and color the window splits to highlight current window
-- Colors set by Catppuccin integration
return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinLeave" },
  opts = {
    only_line_seq = false,      -- highlight top if left window selected
  }
}
