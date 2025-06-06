--- This is the new built-in language server written in Rust.
--- It supports the same feature set as `ruff-lsp`, but with superior performance and no installation required.
--- Note that the `ruff-lsp` server will continue to be maintained until further notice.
--- Refer to the [documentation](https://docs.astral.sh/ruff/editors/) for more details.
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  settings = {},
}
