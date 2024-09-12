local global = vim.g
local o = vim.opt

-- Editor options

o.number = true         -- Print the line number in front of each line
o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line.
-- o.syntax = "on"      -- When this option is set, the syntax with this name is loaded.
o.autoindent = true     -- Copy indent from current line when starting a new line.
o.smartindent = true    -- Do smart autoindenting when starting a new line.
o.ignorecase = true     -- Ignore case in search patterns.
o.smartcase = true      -- Override 'ignorecase' if the search patter containers uppercase chars.
o.cursorline = true     -- Highlight the screen line of the cursor with CursorLine.
o.expandtab = true      -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.shiftwidth = 4        -- Number of spaces to use for each step of (auto)indent.
o.tabstop = 4           -- Number of spaces that a <Tab> in the file counts for.
o.fenc = "UTF-8"        -- File-content encoding for the current buffer.
o.ruler = true          -- Show the line and column number of the cursor position, separated by a comma.
o.mouse = "a"           -- Enable the use of the mouse. "a" you can use on all modes
o.title = true          -- When on, the title of the window will be set to the value of 'titlestring'
o.hidden = true         -- When on a buffer becomes hidden when it is |abandon|ed
o.ttimeoutlen = 0       -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.wildmenu = true       -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.showcmd = true        -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true      -- When a bracket is inserted, briefly jump to the matching one.
o.inccommand = "split"  -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.splitright = true     -- When on, splitting a window will put the new window right of the current one.
o.splitbelow = true     -- When on, splitting a window will put the new window below the current one
o.termguicolors = true  -- Enable 24bit RGB color in the TUI
o.showmode = false      -- Don't show the Insert/Replace/Visual mode, because we are using Lualine plugin
o.cmdheight = 0         -- Save some space on the bottom below the LuaLine