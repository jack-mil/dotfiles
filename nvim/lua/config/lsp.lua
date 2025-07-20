-- Enable all desired language servers in the nvim/lsp directory
-- Names correspond to filename in lsp/*.lua
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
  root_markers = { '.git/' },
})

-- enable error display
vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = { current_line = true },
})

-- activate all specifications in lsp/*.lua files
local configs = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
  local name = vim.fn.fnamemodify(v, ':t:r')
  configs[name] = true
end
vim.lsp.enable(vim.tbl_keys(configs))

-- Set up LSPAttach autocommand to enable features based on client
-- capabilities. A single autocommand can work for multiple LSP servers.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- Enable auto-completion. Use CTRL-Y to select an item.
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
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

function Inspect_lsp_client()
  vim.ui.input({ prompt = 'Enter LSP Client name: ' }, function(client_name)
    if client_name then
      local client = vim.lsp.get_clients({ name = client_name })

      if #client == 0 then
        vim.notify('No active LSP clients found with this name: ' .. client_name, vim.log.levels.WARN)
        return
      end

      -- Create a temporary buffer to show the configuration
      local buf = vim.api.nvim_create_buf(false, true)
      local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = math.floor(vim.o.columns * 0.75),
        height = math.floor(vim.o.lines * 0.90),
        col = math.floor(vim.o.columns * 0.125),
        row = math.floor(vim.o.lines * 0.05),
        style = 'minimal',
        border = 'rounded',
        title = ' ' .. (client_name:gsub('^%l', string.upper)) .. ': LSP Configuration ',
        title_pos = 'center',
      })

      local lines = {}
      for i, this_client in ipairs(client) do
        if i > 1 then table.insert(lines, string.rep('-', 80)) end
        table.insert(lines, 'Client: ' .. this_client.name)
        table.insert(lines, 'ID: ' .. this_client.id)
        table.insert(lines, '')
        table.insert(lines, 'Config & State:')

        local config_lines = vim.split(vim.inspect(this_client), '\n')
        vim.list_extend(lines, config_lines)
      end

      -- Set the lines in the buffer
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Set buffer options
      vim.bo[buf].modifiable = false
      vim.bo[buf].filetype = 'lua'
      vim.bo[buf].bh = 'delete'

      vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
    end
  end)
end
