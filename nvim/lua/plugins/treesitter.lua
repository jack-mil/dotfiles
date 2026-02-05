-- memoize installed capabilities
local installed = {}
local function get_lang(lang)
  return installed[lang]
end
local _queries = {}
local function have_query(lang, query)
  if not get_lang(lang) then
    return
  end
  local key = lang .. ':' .. query
  if _queries[key] == nil then
    _queries[key] = vim.treesitter.query.get(lang, query) ~= nil
  end
  return _queries[key]
end

return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    cmd = { 'TSContext' },
    opts = { mode = 'cursor', max_lines = 2 },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    branch = 'main',
    version = false,
    build = ':TSUpdate',
    lazy = false,
    cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    config = function(...)
      -- Create map of installed languges
      local TS = require('nvim-treesitter')
      for _, lang in ipairs(TS.get_installed('parsers')) do
        installed[lang] = true
      end

      -- enable treesitter autocmd if language is installed (manually with `:TSInstall`)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('enable-treesitter', { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)

          -- skip enabling if parser is not installed for this language
          if lang == nil or not get_lang(lang) then
            return
          end

          -- highlighting
          if have_query(lang, 'highlights') then
            pcall(vim.treesitter.start, ev.buf)
          end

          -- indents
          if have_query(lang, 'indents') then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          -- folds
          if have_query(lang, 'folds') then
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
          end
        end,
      }) -- end AutoCMD
    end  -- config()
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        -- Helper configured in config() below to create buffer-local keymaps
        keys = {
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter-textobjects")
      TS.setup(opts)

      local function attach(buf)
        local ft = vim.bo[buf].filetype
        if not (vim.tbl_get(opts, "move", "enable") and have_query(ft, "textobjects")) then
          return
        end
        ---@type table<string, table<string, string>>
        local moves = vim.tbl_get(opts, "move", "keys") or {}

        for method, keymaps in pairs(moves) do
          for key, query in pairs(keymaps) do
            local queries = type(query) == "table" and query or { query }
            local parts = {}
            for _, q in ipairs(queries) do
              local part = q:gsub("@", ""):gsub("%..*", "")
              part = part:sub(1, 1):upper() .. part:sub(2)
              table.insert(parts, part)
            end
            local desc = table.concat(parts, " or ")
            desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
            desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
            if not (vim.wo.diff and key:find("[cC]")) then
              vim.keymap.set({ "n", "x", "o" }, key, function()
                require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
              end, {
                buffer = buf,
                desc = desc,
                silent = true,
              })
            end
          end
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
        callback = function(ev)
          attach(ev.buf)
        end,
      })
      vim.tbl_map(attach, vim.api.nvim_list_bufs())
    end,
  }
}
