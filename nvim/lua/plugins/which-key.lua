-- Very useful shortcut discovery tool (for coords)
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  version = '^3.17.0',
  opts = {
    preset = 'modern',
    spec = {
      {
        mode = { 'n', 'v' },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { 'g', group = 'goto' },
        { 'z', group = 'fold' },
        { '<leader>o', group = 'view/options', icon = { icon = '󰙵 ', color = 'cyan' } },
        { '<leader>l', group = 'Save/Load Sessions' },
        { '<leader><tab>', group = 'tabs' },
        { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
        {
          '<leader>b',
          group = 'buffer',
          expand = function()
            return require('which-key.extras').expand.buf()
          end,
        },
        {
          '<leader>p',
          group = 'windows',
          proxy = '<c-w>',
          expand = function()
            return require('which-key.extras').expand.win()
          end,
        },
        -- better descriptions
        { 'gx', desc = 'Open with system app' },
      },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
    {
      '<c-w><space>',
      function()
        require('which-key').show({ keys = '<c-w>', loop = true })
      end,
      desc = 'Window Hydra Mode (which-key)',
    },
  },
}
