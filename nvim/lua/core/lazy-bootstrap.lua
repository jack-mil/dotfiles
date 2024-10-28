-- Bootstrap lazy.nvim (from: https://lazy.folke.io/installation)
local lazypath = vim.env.LAZY or vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.runtimepath:prepend(lazypath)
