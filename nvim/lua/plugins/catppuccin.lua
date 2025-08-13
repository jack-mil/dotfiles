-- Colorscheme
-- https://github.com/catppuccin/nvim
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'frappe',                 -- latte, frappe, macchiato, mocha
    transparent_background = true,      -- important
    float = { transparent = true },
    dim_inactive = { enabled = false }, -- doesn't work with transparent bg
    background = {                      -- :h background
      light = 'latte',
      dark = 'frappe',
    },
    compile_path = vim.fn.stdpath('cache') .. '/catppuccin', -- enable compiling theme
    show_end_of_buffer = true,                               -- seems to be bugged??
    term_colors = true,
    default_integrations = false,
    integrations = {
      leap = true,
      which_key = true,
      fzf = true,
      semantic_tokens = true,
      treesitter = true,
      treesitter_context = true,
      colorful_winsep = {
        enabled = true,
        color = 'mauve',
      },
      snacks = {
        enabled = true,
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
