-- Colorscheme
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'frappe',   -- latte, frappe, macchiato, mocha
    transparent_background = true,  -- important
    dim_inactive = { enabled = false },   -- doesn't work with transparent bg
    background = {        -- :h background
      light = 'latte',
      dark = 'frappe',
    },
    show_end_of_buffer = false, -- seems to be bugged??
    term_colors = true,
    default_integrations = false,
    integrations = {
      which_key = true,
      leap = true,
      dashboard = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      colorful_winsep = {
        enabled = true,
        color = "yellow"
      },
      compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',   -- enable compiling theme
    },
  },
  init = function()   -- loads the colorscheme
    vim.cmd.colorscheme('catppuccin-frappe')
  end,
}
