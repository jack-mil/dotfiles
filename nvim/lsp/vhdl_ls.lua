---@brief
---
--- Install vhdl_ls from https://github.com/VHDL-LS/rust_hdl and add it to path
---
--- ```
return {
  cmd = { 'vhdl_ls' },
  filetypes = { 'vhd', 'vhdl' },
  root_markers = {
    'vhdl_ls.toml',
    '.vhdl_ls.toml',
  },
}
