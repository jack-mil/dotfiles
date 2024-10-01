-- Colorscheme
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'frappe',   -- latte, frappe, macchiato, mocha
    background = {    -- :h background
      light = 'latte',
      dark = 'frappe',
    },
    show_end_of_buffer = false, -- seems to be bugged??
    dim_inactive = { enabled = false },
    term_colors = true,
    transparent_background = true,
    compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',
    default_integrations = false,
    integrations = {
      which_key = true,
      leap = true,
      dashboard = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
    },
  },
  init = function()
    vim.cmd.colorscheme('catppuccin-frappe')
  end,
}
