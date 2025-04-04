-- Sets up autocmd and highlight group to show trailing whitespace
vim.cmd([[match TrailingWhitespace /\s\+$/]])

vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Error' })

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.opt.listchars.trail = nil
    vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Whitespace' })
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    vim.opt.listchars.trail = space
    vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Error' })
  end,
})

-- Autocommands to swap relative numbers in insert/normal mode
vim.api.nvim_create_augroup('numbertoggle', { clear = true })

-- Define the autocommands
vim.api.nvim_create_autocmd(
  { 'BufEnter', 'FocusGained', 'InsertLeave' },
  { pattern = '*', command = 'set relativenumber', group = 'numbertoggle' }
)
vim.api.nvim_create_autocmd(
  { 'BufLeave', 'FocusLost', 'InsertEnter' },
  { pattern = '*', command = 'set norelativenumber', group = 'numbertoggle' }
)
