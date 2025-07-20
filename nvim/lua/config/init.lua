-- Define the setup function for my config module
-- Used in top-level init.lua as require('config').setup()

local M = {}

-- Load all user config (and then plugins)
function M.setup()
  require('config.settings')
  require('config.keymaps')
  require('config.commands')
  require('config.autocmd')
  require('config.builtin')
  -- Setup new v11 LSP configuration
  if vim.version.ge(vim.version(), { 0, 11, 0 }) and not vim.g.vscode then require('config.lsp') end

  -- Lastly, load plugins from lazy
  require('config.lazy-config')
end

return M
