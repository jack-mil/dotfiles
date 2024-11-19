-- fzf fuzzy finder integration for neovim
return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  opts = {
    -- 'default', -- neovim builtin previewer + icons
    'default-title', -- preset without title in prompt
    fzf_colors = true,
  },
}
