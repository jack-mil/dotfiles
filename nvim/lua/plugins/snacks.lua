return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    ---@type snacks.picker.Config
    explorer = {},
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = { position = 'right' },
          },
        },
      },
    },
  },
  keys = {
    {
      '<leader>e',
      function()
        require('snacks').explorer()
      end,
      desc = 'Explorer Snacks (cwd)',
    },
  },
}
