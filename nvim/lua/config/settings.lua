local g = vim.g
local o = vim.opt

local autocmd = vim.api.nvim_create_autocmd
local settings_group = vim.api.nvim_create_augroup('UserSettings', { clear = true })

o.mouse = 'a' -- Enable the use of the mouse. 'a' you can use on all modes

-- Indentation
o.tabstop = 2        -- Number of spaces that a <Tab> in the file counts for.
o.softtabstop = 2    -- Number of spaces that a <Tab> counts for when performing editing operations.
o.shiftwidth = 2     -- Number of spaces to use for each step of (auto)indent.
o.expandtab = true   -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
-- indent options may be overridden by LSP or TS
o.smartindent = true -- Do smart auto indenting when starting a new line.
o.autoindent = true  -- Copy indent from current line when starting a new line.

-- Appearance
o.wrap = false              -- Line wrapping off by default (toggle with <leader>ow)
o.linebreak = true          -- Break lines at reasonable place.
o.breakindent = true        -- Preserve visual indentation on wrapped lines
o.briopt = 'sbr'            -- Options for break indent, puts wrap char in first col
o.number = true             -- Print the line number in front of each line
o.relativenumber = true     -- Show the line number relative to the line with the cursor in front of each line.
o.signcolumn = 'number'     -- Put signs (icons from plugins) in the number column, if present.
o.cursorline = true         -- Highlight the screen line of the cursor with CursorLine.
o.ruler = true              -- Show the line and column number of the cursor position, separated by a comma.
o.showmatch = true          -- When a bracket is inserted, briefly jump to the matching one.
o.laststatus = 3            -- (Single) global status bar (LuaLine)
o.scrolloff = 10            -- Keep 10 lines above/below cursor
o.sidescrolloff = 8         -- Keep 8 columns left/right of cursor

o.showcmd = true            -- Show (partial) command in the last line of the screen.
o.showcmdloc = 'statusline' -- Will fill the %S placeholder (in lualine status bar)
o.showmode = false          -- Don't show the Insert/Replace/Visual mode, because using LuaLine plugin
o.cmdheight = 0             -- Save some space on the bottom below the LuaLine
if vim.g.vscode then        -- Weird work-around for code plugin (rarely used)
  o.cmdheight = 1
end

-- Set/unset relative number when enter/exit insert mode
autocmd('InsertLeave', { pattern = '*', group = settings_group, command = 'setlocal relativenumber' })
autocmd('InsertEnter', { pattern = '*', group = settings_group, command = 'setlocal norelativenumber' })

-- Searching
o.ignorecase = true -- Ignore case search patterns.
o.smartcase = true  -- Override 'ignorecase' if the search patter containers uppercase chars.
o.incsearch = true  -- Show matches as typed (default=true)

-- File
o.fenc = 'UTF-8'   -- File-content encoding for the current buffer.
o.ff = 'unix'      -- Always use LF EOL.
o.ffs = 'unix,dos' -- Try these EOL in order.
o.fixeol = true    -- Insert missing newline at end of file

o.ttimeoutlen = 0  -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.

-- Behavior
o.wildmenu = true                                   -- Command <TAB> completion menu (default: on)
o.wildignorecase = true                             -- Ignore case when completing filenames/dirs
o.wildmode = 'longest:full,full'                    -- completion menu options
o.errorbells = true                                 -- Enable 'bells', actually flash,
o.visualbell = true                                 -- Flash instead on errors
o.hidden = true                                     -- Buffers become hidden when abandoned.
o.undofile = true                                   -- Save undo history to state file when writing a buffer
o.completeopt = 'menuone,noinsert,noselect,preview' -- Options for C-X completion menu
o.clipboard:append('unnamedplus')                   -- Use system clipboard

-- Spellcheck (suggestions: z= , navigate [s ]s, add/remove zg zw)
o.spell = false                        -- default off, see autocmd
o.spelloptions = 'camel,noplainbuffer' -- Spellcheck CamelCase
autocmd('Filetype', {
  group = settings_group,
  pattern = { 'gitcommit', 'md', 'tex', 'txt' },
  command = 'setlocal spell',
  desc = 'Enable spellcheck on certain filetypes',
})

-- Folding
o.foldlevel = 99      -- Start with all open
o.foldlevelstart = 99
o.foldcolumn = '0'    -- No foldcolum be default (enabled with LSP)
o.foldtext = ''       -- Enable syntax highlighting on folds
o.foldmethod = 'syntax' -- Use syntx folding by default, my be overridded by LSP or TS
-- These are overridden by LSP if supported foldingRange

-- Window splitting
o.splitright = true -- Splitting a window will put the new window right of the current one.
o.splitbelow = true -- Splitting a window will put the new window below the current one
o.inccommand =
'split'             -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.

-- Terminal
o.title = true         -- When on, the title of the window will be set to the value of 'titlestring'
o.termguicolors = true -- Enable 24bit RGB color in the TUI

if vim.version.ge(vim.version(), { 0, 11, 0 }) then
  o.winborder = 'rounded' -- rounded floating windows (v0.11.0 only)
end

-- White space (toggle with <leader>oz)
o.list = false
o.showbreak = '↪ ' -- Character at the start of wrapped lines
local space = '·'
o.listchars:append({
  tab = '|-',
  multispace = space,
  lead = space,
  trail = space,
  nbsp = '␣',
  extends = '⟩',
  precedes = '⟨',
})

-- Man(page) command
g.man_hardwrap = 0 -- use soft wrapping for displaying manpages

-- Options based on file types
-- Wrap markdown files by default
autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

autocmd('BufWinEnter', {
  pattern = { 'man', 'dashboard', 'help' },
  callback = function(args)
    local bufnr = args.buf
    local buf = vim.bo[bufnr]
    vim.wo[bufnr].number = false
    vim.wo[bufnr].relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.fillchars:append({ eob = ' ' })
    vim.opt_local.showbreak = 'NONE'
  end,
})
