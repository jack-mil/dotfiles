-- My autocommands for more complex behaviour

local autocmd = vim.api.nvim_create_autocmd

local mygroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- Set up autocmd and highlight group to show trailing whitespace
-- Create new highlight group (inherits Error style)
vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Error' })
vim.cmd([[match TrailingWhitespace /\_s\+$/]])
-- Disable trailing space highlight when enter insert mode
autocmd('InsertEnter', {
  group = mygroup,
  callback = function()
    vim.opt.listchars.trail = nil
    vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Whitespace' })
  end,
})
-- Enable trailing space highlight on leave insert mode
autocmd('InsertLeave', {
  group = mygroup,
  callback = function()
    vim.opt.listchars.trail = space
    vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Error' })
  end,
})

-- Visual blink when copying
autocmd('TextYankPost', {
  group = mygroup,
  desc = 'Highlight selection on yank',
  callback = function()
    vim.highlight.on_yank({ timeout = 300, higroup = 'TermCursor' })
  end,
})

-- Create directories when saving files
autocmd('BufWritePre', {
  group = mygroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, 'p') end
  end,
})

-- Auto-resize splits when window is resized
autocmd('VimResized', {
  group = mygroup,
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Autocommands to toggle relative numbers in insert/normal mode
vim.api.nvim_create_augroup('numbertoggle', { clear = true })

autocmd({ 'BufEnter', 'InsertLeave' }, { pattern = '*', command = 'set relativenumber', group = 'numbertoggle' })
autocmd({ 'BufLeave', 'InsertEnter' }, { pattern = '*', command = 'set norelativenumber', group = 'numbertoggle' })
