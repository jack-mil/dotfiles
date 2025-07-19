-- Lazy.nvim configuration options.
-- see: https://lazy.folke.io/configuration

local config = {} -- to return

-- import plugins from subdirectory
config.spec = { {
  import = 'plugins',
  cond = function()
    return not vim.g.vscode
  end,
} }

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
config.performance = {
  rtp = {
    disabled_plugins = {
        -- 'gzip', 'tarPlugin', 'tohtml', 'zipPlugin', 
--       '2html_plugin', 'getscript', 'getscriptPlugin', 'gzip',
--       'logipat', 'man', 'matchit', 'matchparen', 'netrw',
--       'netrwFileHandlers', 'netrwPlugin', 'netrwSettings',
--       'rplugin', 'rrhelper', 'shada', 'spellfile_plugin',
--       'tar', 'tarPlugin', 'tohtml', 'tutor', 'vimball',
--       'vimballPlugin', 'zip', 'zipPlugin',
    }
  }
}

-- config.profiling = { require = true }

-- configure lazy plugin
require('lazy').setup(config)
