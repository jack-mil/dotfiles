-- Enable all desired language servers in the nvim/lsp directory
-- Names coorispond to filename in lsp/*.lua
-- Requires Neovim v0.11

-- common lsp config, will be merged with everything in <rtp>/lsp/<name>.lua
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { '.git' },
})

-- enable error display
vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

vim.lsp.enable('lua-language-server')

-- Set up LSPAttach autocommand to enable features based on client
-- capabilities. A single autocommand can work for multiple LSP servers.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
    if
      not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting')
    then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- Add noselect to completeopt, otherwise autocompletion is annoying
vim.opt.completeopt:append('noselect')

-- rounded floating windows (might be default?)
-- Only V0.11
o.winborder = 'rounded'
