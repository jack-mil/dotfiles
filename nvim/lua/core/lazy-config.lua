-- Lazy.nvim configuration options.
-- see: https://lazy.folke.io/configuration

local config = {} -- to return

-- import plugins from subdirectory
config.spec = { { import = 'plugins' } }

-- I don't know what lua rocks are, disable it (undocumented (?))
config.rocks = { enabled = false }

-- Also remove rockspec from pkg sources
config.pkg = { sources = { 'lazy', 'packspec' } }

-- colorscheme that will be used when installing plugins.
config.install = { colorscheme = { 'catppuccin' } }

-- disable auto updates
config.checker = { enabled = false }

-- disable auto-reload
config.change_detection = { enabled = false }

-- Lazy UI options
config.ui = { border = 'rounded', backdrop = 80 }

-- disable a bunch of neovim builtin plugins I don't use
-- stylua: ignore
-- config.performance = {
--   rtp = {
--     disabled_plugins = {
--       '2html_plugin', 'getscript', 'getscriptPlugin', 'gzip',
--       'logipat', 'man', 'matchit', 'matchparen', 'netrw',
--       'netrwFileHandlers', 'netrwPlugin', 'netrwSettings',
--       'rplugin', 'rrhelper', 'shada', 'spellfile_plugin',
--       'tar', 'tarPlugin', 'tohtml', 'tutor', 'vimball',
--       'vimballPlugin', 'zip', 'zipPlugin',
--     }
--   }
-- }

-- config.profiling = { require = true }

-- return table for use with require('lazy').setup(config)
return config
