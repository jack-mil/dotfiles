-- My autocommands for more complex behaviour
local autocmd = vim.api.nvim_create_autocmd

local mygroup = vim.api.nvim_create_augroup('UserAutoCmds', { clear = true })

-- Set up autocmd and highlight group to show trailing whitespace
-- Create new highlight group (inherits Error style)
vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Error' })
vim.cmd([[match TrailingWhitespace /\_s\+$/]])

-- Disable trailing space highlight when enter insert mode
autocmd('InsertEnter', {
  group = mygroup,
  desc = 'Disable trailing whitespace error highlight',
  callback = function()
    vim.opt.listchars.trail = nil
    vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Whitespace' })
  end,
})

-- Enable trailing space highlight on leave insert mode
autocmd('InsertLeave', {
  group = mygroup,
  desc = 'Enable trailing whitespace error highlight',
  callback = function()
    vim.opt.listchars.trail = space
    vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Error' })
  end,
})

-- Visual blink when copying
autocmd('TextYankPost', {
  group = mygroup,
  desc = 'Blink highlight selection on yank',
  callback = function()
    vim.highlight.on_yank({ timeout = 300, higroup = 'IncSearch' })
  end,
})

-- Create directories when saving files
autocmd('BufWritePre', {
  group = mygroup,
  desc = 'Create directories when writing file',
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, 'p') end
  end,
})

-- Auto-resize splits when window is resized
autocmd('VimResized', {
  group = mygroup,
  desc = 'Auto-resize window splits when NVIM resized',
  command = 'tabdo wincmd =',
})
