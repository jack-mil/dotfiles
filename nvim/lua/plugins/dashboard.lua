-- Dashboard and quick access to recent files
return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = {
    theme = 'hyper',
    config = {
      week_header = { enable = true },
      disable_move = true,
      shortcut = {
        { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
        { desc = ' Lazy', group = 'Number', action = 'Lazy', key = 'l' },
        -- {
        --   desc = '󰱼 Files',
        --   group = 'Label',
        --   action = 'Telescope find_files',
        --   key = 'f',
        -- },
        -- {
        --   desc = ' Apps',
        --   group = 'DiagnosticHint',
        --   action = 'Telescope app',
        --   key = 'a',
        -- },
        -- {
        --   desc = ' dotfiles',
        --   group = 'Number',
        --   action = 'Telescope dotfiles',
        --   key = 'd',
        -- },
      },
      footer = {},
    },
  },
  dependencies = { {'nvim-tree/nvim-web-devicons'} }
}
