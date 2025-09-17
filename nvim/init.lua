-- init.lua gets executed when Neovim starts
-- This is the config entry point

if vim.loader then vim.loader.enable(true) end -- experimental loader

-- Bootstrap lazy.nvim (from: https://lazy.folke.io/installation)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Configure my user settings, then plugins
require('config.settings')
require('config.keymaps')
require('config.commands')
require('config.autocmd')
require('config.builtin')
-- Setup new v11 LSP configuration
if vim.version.ge(vim.version(), { 0, 11, 0 }) and not vim.g.vscode then require('config.lsp') end

-- Lastly, load plugins from lazy
require('config.lazy-config')
