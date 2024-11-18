if vim.loader then vim.loader.enable() end -- experimental loader (?)

-- download lazy plugin loader
require('core.lazy-bootstrap')

-- Configure my user settings before plugins
require('core.settings')
require('core.keymaps')

-- Setup lazy.nvim (loads all other plugins)
require('core.lazy-config')

-- load other stuff (trailing whitespace auto_cmd)
require('core.autocmd')
