-- Plugin to show indentation levels

-- These groups set by catppuccin color scheme
local color_order = {
  'RainbowRed',
  'RainbowYellow',
  'RainbowViolet',
  'RainbowOrange',
  'RainbowGreen',
  'RainbowBlue',
  'RainbowCyan',
}

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  enabled = false, -- Disabled now, bloat
  event = 'BufReadPost',
  cmd = { 'IBLEnable', 'IBLDisable', 'IBLToggle', 'IBLEnableScope', 'IBLDisableScope', 'IBLToggleScope' },
  opts = {
    indent = {
      char = '┊',
      highlight = color_order,
    },
    whitespace = { remove_blankline_trail = true },
    exclude = {
      filetypes = { 'help', 'dashboard', 'lazy', 'neo-tree', 'NvimTree', 'notify', 'toggleterm' },
      buftypes = { 'nofile', 'prompt', 'quickfix', 'terminal' },
    },
  },
}
