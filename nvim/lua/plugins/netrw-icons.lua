-- Adds file icons to the built-in netrw directory browser
return {
  'prichrd/netrw.nvim',
  enabled = false,
  ft = { 'netrw' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = { use_devicons = true },
}
