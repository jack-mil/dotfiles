-- Statusline plugin
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'catppuccin',
      disabled_filetypes = { 'dashboard' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },

      lualine_x = {
        { 'encoding', show_bomb = true },
        { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } },
          'filetype'
      },
      lualine_y = { 'progress', 'selectioncount' },
      lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
    },
  },
}

