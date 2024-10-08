-- Trim trailing whitespace. Loaded with keybinding
return {
  'cappyzawa/trim.nvim',
  cmd = { 'Trim', 'TrimToggle' },
  opts = {
    ft_blocklist = { 'markdown' }, -- don't trim markdown files automatically
    trim_on_write = false, -- use my own highlighting (looks better)
  },
}
