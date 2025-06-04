-- Set `mapleader` and `maplocalleader` before
-- running lazy.nvim so that mappings are correct.
vim.g.mapleader = ' '      -- <space>
vim.g.maplocalleader = ' ' -- <space>

function map(mode, shortcut, command, opts)
  opts = opts or {}                                       -- Use an empty table if no options are provided
  local default_opts = { noremap = true, silent = true }
  opts = vim.tbl_deep_extend('force', default_opts, opts) -- Merge tables, with opts taking priority
  vim.keymap.set(mode, shortcut, command, opts)
end

function nmap(shortcut, command, opts)
  map('n', shortcut, command, opts)
end

function imap(shortcut, command, opts)
  map('i', shortcut, command, opts)
end

function vmap(shortcut, command, opts)
  map('v', shortcut, command, opts)
end

-- use jj to exit insert mode (not present in English)
imap('jj', '<Esc>')

-- type commands without Shift
nmap(';', ':', { silent = false, desc = 'CMD enter mode (Ex)' })

-- move up/down by displayed lines (wrapped) if no count given
-- in visual and normal mode
map({ 'n', 'v' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ 'n', 'v' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })
-- disable navigation by arrow keys
nmap('<up>', '<nop>')
nmap('<down>', '<nop>')

imap('<C-H>', '<C-W>')   -- Ctrl-Backspace that I am used to (learn to use <C-W?)
imap('<C-b>', '<C-o>db') -- Delete word backward (same as above)
imap('<C-e>', '<C-o>de') -- Delete word forward

-- when forget to open with sudo
map('c', 'w!!', 'execute "write !sudo tee % > /dev/null" <bar> edit!', { noremap = true, silent = false })

-- mapping to insert newline above/below in normal mode
nmap('<C-J>', 'mao<Esc>`a')
nmap('<C-K>', 'maO<Esc>`a')

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- buffer save/write Keymaps
nmap('<leader>q', ':q<cr>', { desc = 'QUIT FILE' })
nmap('<leader>Q', ':confirm qa<cr>', { desc = 'FORCE QUIT FILE' })
nmap('<leader>w', ':w<cr>', { desc = 'Write File' })
nmap('<leader>W', ':wa<cr>', { desc = 'Force Write File' })
nmap('<leader>M', ':messages<cr>', { desc = 'Show Messages' })

-- Splits and Windows
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
nmap('<leader>bx', ':bdelete<cr>', { desc = 'Last Buffer' })
nmap('<leader>bs', ':source %<cr>', { desc = 'Source Buffer' })
nmap('<F5>', ':buffers<cr>:buffer<space>', { desc = 'Pick buffer', silent = false })

-- Tabs
nmap("<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
nmap("<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
nmap("<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
nmap("<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
nmap("<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
nmap("<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
nmap("<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- g<Tab>, gt, and gT already navigate between tabs

-- Nvim Options and Commands
nmap('<leader>ow', ':set invwrap<cr>', { desc = 'Toggle Wrap Lines' })
nmap('<leader>ol', ':set invlinebreak<cr>', { desc = 'Toggle Break Lines (wrap)' })
nmap('<leader>oh', ':set invhlsearch<cr>', { desc = 'Toggle Search Highlight', silent = false })
nmap('<leader>oz', ':set invlist<cr>', { desc = 'Toggle Show Whitespace' })
nmap('<leader>os', ':set invspell<cr>', { desc = 'Toggle Spell Check' })
nmap('<leader>op', ':pwd<cr>', { desc = 'Current Working Directory', silent = false })

-- location list
map("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

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

-- Neo-tree file browser panel
-- nmap('<leader>e', ':Neotree reveal toggle<cr>', { desc = 'Toggle Explorer' })
-- nmap('<leader>n', function()
--   if vim.bo.filetype == 'neo-tree' then
--     vim.cmd.wincmd('p')
--   else
--     vim.cmd.Neotree('focus')
--   end
-- end, { desc = 'Toggle Explorer Focus' })
