-- Colorscheme
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'frappe', -- latte, frappe, macchiato, mocha
    transparent_background = true, -- important
    dim_inactive = { enabled = false }, -- doesn't work with transparent bg
    background = { -- :h background
      light = 'latte',
      dark = 'frappe',
    },
    compile_path = vim.fn.stdpath('cache') .. '/catppuccin', -- enable compiling theme
    show_end_of_buffer = true, -- seems to be bugged??
    term_colors = true,
    default_integrations = false,
    integrations = {
      fzf = true,
      which_key = true,
      leap = true,
      dashboard = true,
      semantic_tokens = true,
      neotree = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      colorful_winsep = {
        enabled = true,
        color = 'yellow',
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
          ok = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
          ok = { 'underline' },
        },
        inlay_hints = {
          background = true,
        },
      },
    },
  },
  init = function() -- loads the colorscheme
    vim.cmd.colorscheme('catppuccin-frappe')
  end,
}
