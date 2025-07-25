-- A Floating terminal buffer than can be toggled and remembers state.
-- Largely taken from https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- with modifications

-- terminal module to return
local M = {}
-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd('TermClose', {
  group = vim.api.nvim_create_augroup('termAuGroup', { clear = true }),
  callback = function()
    if vim.v.event.status == 0 then vim.api.nvim_buf_delete(0, {}) end
  end,
})

-- Persistent state
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false,
}

function M.toggle_term()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

  -- Set transparent background for the window
  vim.api.nvim_win_set_option(
    terminal_state.win,
    'winhighlight',
    'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder'
  )

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, 'FloatingTermNormal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'FloatingTermBorder', { bg = 'none' })

  -- Start terminal if not already running
  local has_terminal = false
  -- search for any non-zero line... Surely there is a better way to detect
  -- an empty buffer...
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= '' then
      has_terminal = true
      break
    end
  end

  if not has_terminal then vim.fn.termopen(os.getenv('SHELL')) end

  terminal_state.is_open = true
  vim.cmd('startinsert')

  -- Set up auto-close on buffer leave
  vim.api.nvim_create_autocmd('BufLeave', {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true,
  })
end -- FloatingTerminal()

-- Function to explicitly close the terminal
function M.close_term()
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

return M
