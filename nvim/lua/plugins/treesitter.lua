return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    cmd = { 'TSContext' },
    opts = { mode = 'cursor', max_lines = 2 },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
          goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
        },
      },
    },
  },
}
