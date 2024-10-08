vim.loader.enable() -- experimental loader (?)

require('core.lazy-bootstrap') -- download lazy plugin loader

-- Configure my user settings before plugins
require('core.settings')
require('core.keymaps')

-- Setup lazy.nvim (loads all other plugins)
require('lazy').setup(require('core.lazy-config'))

-- load other stuff (trailing whitespace auto_cmd)
require('core.autocmd')
