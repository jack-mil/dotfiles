return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'BufReadPre',
  opts = {
    indent = {
      char = '┊',
      highlight = { -- These groups set by catppuccin color scheme
        "RainbowRed",
        "RainbowYellow",
        "RainbowViolet",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowBlue",
        "RainbowCyan",
      },
    },
    exclude = {
      filetypes = {
        'help',
        'dashboard',
        'lazy',
        ''
      },
    },
  },
}
