-- Disable some in built plugins completely
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'logipat',
  'remote_plugins',
  'rrhelper',
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Deactivate unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
