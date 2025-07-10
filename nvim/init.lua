if vim.loader then vim.loader.enable() end -- experimental loader (?)

-- TODO: autoload everything in core/ directory

-- download lazy plugin loader
require('core.lazy-bootstrap')

-- Configure my user settings before plugins
require('core.settings')
require('core.keymaps')

-- Setup lazy.nvim (loads all other plugins)
require('core.lazy-config')

-- Setup new v11 LSP configuration
if vim.version.ge(vim.version(), { 0, 11, 0 }) 
  and not vim.g.vscode then 
  require('core.lsp') 
end

-- load other stuff (trailing whitespace auto_cmd)
require('core.autocmd')
