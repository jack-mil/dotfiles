-- Convenience function for setting all these key-bindings
local function map(mode, shortcut, command, opts)
  opts = opts or {} -- Use an empty table if no options are provided
  local default_opts = { noremap = true, silent = true }
  opts = vim.tbl_deep_extend('force', default_opts, opts) -- Merge tables, with opts taking priority
  vim.keymap.set(mode, shortcut, command, opts)
end

local function nmap(shortcut, command, opts)
  map('n', shortcut, command, opts)
end

local function imap(shortcut, command, opts)
  map('i', shortcut, command, opts)
end

local function vmap(shortcut, command, opts)
  map('v', shortcut, command, opts)
end

-- Set `mapleader` and `maplocalleader` before
-- running lazy.nvim so that mappings are correct.
vim.g.mapleader = ' ' -- <space>
vim.g.maplocalleader = ' ' -- <space>

-- use jj/jk to exit insert mode (not present in English)
imap('jj', '<Esc>')
imap('jk', '<Esc>')

-- type commands without Shift
nmap(';', ':', { silent = false, desc = 'CMD enter mode (Ex)' })

-- move up/down by displayed lines (wrapped) if no count given
-- in visual and normal mode
map({ 'n', 'v' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ 'n', 'v' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Center screen when jumping
nmap('n', 'nzzzv', { desc = 'Next search result (centered)' })
nmap('N', 'Nzzzv', { desc = 'Previous search result (centered)' })
nmap('<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
nmap('<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- disable navigation by arrow keys
nmap('<up>', '<nop>')
nmap('<down>', '<nop>')

imap('<A-b>', '<C-o>dw') -- Delete word forward in insert mode (GNU Readline)

imap('<C-e>', '<C-o>$') -- Emacs-style end of line in insert mode
imap('<C-a>', '<C-o>0') -- Emacs-style start of line in insert mode

nmap('<leader>c', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- When forget to open with sudo
map('c', 'w!!', 'execute "write !sudo tee % > /dev/null" <bar> edit!', { silent = false })

-- Move Lines or Selection Up/Down (accepts <count> modifiers)
nmap('<A-k>', "<cmd>exec 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
nmap('<A-j>', "<cmd>exec 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
-- imap('<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' }) -- disabled insert mode version
-- imap('<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
-- is smart about preserving current selection
vmap('<A-j>', ":<C-u>exec \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vmap('<A-k>', ":<C-u>exec \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- Copy Line or selection Up/Down (accepts <count> modifiers)
nmap('<A-K>', "<cmd>exec 'copy .-' . v:count1<cr>", { desc = 'Copy Line Up' })
nmap('<A-J>', "<cmd>exec 'copy .+' . (v:count1 - 1)<cr>", { desc = 'Copy Line Down' })

nmap('J', 'mzJ`z', { desc = 'Join line below and keep cursor position' })

-- Comments
nmap('gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
nmap('gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- Indent
vmap('<', '<gv', { desc = 'Indent left and reselect' })
vmap('>', '>gv', { desc = 'Indent right and reselect' })

-- buffer save/write Keymaps
nmap('<leader>q', ':q<cr>', { desc = 'QUIT FILE' })
nmap('<leader>Q', ':confirm qa<cr>', { desc = 'FORCE QUIT FILE' })
nmap('<leader>w', ':w<cr>', { desc = 'Write File' })
nmap('<leader>W', ':wa<cr>', { desc = 'Force Write File' })
nmap('<leader>M', ':messages<cr>', { desc = 'Show Messages' })

-- Splits and Windows
nmap('<C-h>', '<C-w>h', { desc = 'Move to left window' })
nmap('<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
nmap('<C-k>', '<C-w>k', { desc = 'Move to top window' })
nmap('<C-l>', '<C-w>l', { desc = 'Move to right window' })
-- nmap('<leader>pv', '<C-w>v', { desc = 'Split Vertically', silent = false })
-- nmap('<leader>ph', '<C-w>s', { desc = 'Split Horizontally', silent = false })
-- nmap('<leader>pe', '<C-w>=', { desc = 'Equal Split', silent = false })
-- nmap('<leader>px', ':close<CR>', { desc = 'Close split', silent = false })
-- nmap('<leader>po', ':only<CR>', { desc = 'Single Pane', silent = false })

-- Buffers
nmap('<Tab>', ':bnext<cr>')
nmap('<S-Tab>', ':bprevious<cr>')
nmap('<left>', ':bprevious<cr>')
nmap('<right>', ':bnext<cr>')
nmap('<leader>bn', ':bnext<cr>', { desc = 'Next Buffer' })
nmap('<leader>bp', ':bprevious<cr>', { desc = 'Previous Buffer' })
nmap('<leader>bl', ':blast<cr>', { desc = 'Last Buffer' })
nmap('<leader>bx', ':bdelete<cr>', { desc = 'Close Buffer' })
nmap('<leader>bs', ':source %<cr>', { desc = 'Source Buffer' })
nmap('<F5>', ':buffers<cr>:buffer<space>', { desc = 'Pick buffer', silent = false })

-- Tabs
nmap('<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
nmap('<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
nmap('<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
nmap('<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
nmap('<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
nmap('<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
nmap('<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
-- g<Tab>, gt, and gT already navigate between tabs

-- Nvim Options and Commands
nmap('<leader>ow', ':set invwrap<cr>', { desc = 'Toggle Wrap Lines' })
nmap('<leader>ol', ':set invlinebreak<cr>', { desc = 'Toggle Break Lines (wrap)' })
nmap('<leader>oh', ':set invhlsearch<cr>', { desc = 'Toggle Search Highlight', silent = false })
nmap('<leader>oz', ':set invlist<cr>', { desc = 'Toggle Show Whitespace' })
nmap('<leader>os', ':set invspell<cr>', { desc = 'Toggle Spell Check' })
nmap('<leader>op', ':pwd<cr>', { desc = 'Current Working Directory', silent = false })

-- Less Style keybindings for help/man pages
-- (because I can't break muscle memory)
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function(args)
    local bufnr = args.buf
    local buf = vim.bo[bufnr]
    if not buf.modifiable then
      local opts = { buffer = bufnr }
      nmap('d', '<C-d>', opts)
      nmap('u', '<C-u>', opts)
    end
  end,
  desc = 'Set less-like paging in non-modifiable buffers',
})

-- Copy open buffer filepath
nmap('<leader>P', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('file:', path)
end, { desc = 'Copy open buffer filepath' })

-- location list
map('n', '<leader>xl', function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Location List' })

-- quickfix list
map('n', '<leader>xq', function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Quickfix List' })

-- Open/Toggle floating terminal
nmap('<leader>t', ':Terminal toggle<CR>', { desc = 'Toggle floating terminal' })
map('t', '<Esc>', '<C-\\><C-N>:Terminal close<CR>', { desc = 'Close floating terminal from terminal mode' })

-- =========================
-- PLUGIN KEYMAPS
-- =========================

-- FZF bindings
nmap('<C-O>', ':FzfLua files<cr>', { desc = 'Fuzzy select files in cwd' })
nmap('<C-P>', ':FzfLua builtin<cr>', { desc = 'Command pallet' })
nmap('<F1>', ':FzfLua helptags<cr>', { desc = 'Neovim Help Tags' })
nmap('<C-\\>', ':FzfLua buffers<cr>', { desc = 'Fuzzy select open buffers' })
nmap('<C-F>', ':FzfLua live_grep_glob<cr>', { desc = 'Grep all files in project (Glob)' })

nmap('<leader>oZ', ':Trim<cr>', { desc = 'Trim Trailing Whitespace' })
nmap('<leader>oc', ':ColorizerToggle<cr>', { desc = 'Preview Colors (toggle)' })
nmap('<leader>L', ':Lazy<cr>', { desc = 'Lazy Dashboard' })

-- load the session for the current directory
nmap('<leader>ls', function()
  require('persistence').load()
end, { desc = 'Load last session for CWD' })

-- select a session to load
nmap('<leader>lS', function()
  require('persistence').select()
end, { desc = 'Select session' })

-- load the last session
nmap('<leader>ll', function()
  require('persistence').load({ last = true })
end, { desc = 'Load last session' })

-- stop Persistence => session won't be saved on exit
nmap('<leader>ld', function()
  require('persistence').stop()
end, { desc = 'Disable session saving' })
