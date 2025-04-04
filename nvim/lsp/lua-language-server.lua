---@brief
---
---https://github.com/luals/lua-language-server
--
-- Lua language server.
-- `lua-language-server` can be installed by following the instructions [here](https://luals.github.io/#neovim-install).
return {
  cmd = { 'lua-language-server' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    '.git',
  },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      telemetry = { enable = false }, -- removed since v3.6.5
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
    },
  },
}
