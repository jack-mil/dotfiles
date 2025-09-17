---@brief
--- https://github.com/zigtools/zls
---
--- Zig LSP implementation + Zig Language Server

return {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' },
  workspace_required = false,
  settings = {
    zls = { semantic_tokens = 'partial', build_on_save = true },
  },
}
