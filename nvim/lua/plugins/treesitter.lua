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
    event = { 'VeryLazy' },
    cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    config = function(...)
      local TS = require('nvim-treesitter')
      -- .setup() not required unless overriding `install_dir`
      -- TS.setup(opts)

      -- memoize installed capabilities
      local installed = {}
      for _, lang in ipairs(TS.get_installed('parsers')) do
        installed[lang] = true
      end

      local _queries = {}
      local function have_query(lang, query)
        local key = lang .. ':' .. query
        if _queries[key] == nil then
          _queries[key] = vim.treesitter.query.get(lang, query) ~= nil
        end
        return _queries[key]
      end

      -- enable treesitter autocmd if language is installed (manually with `:TSInstall`)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter', { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)

          -- skip enabling if parser is not installed for this language
          if lang == nil or installed[lang] == nil then
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
}
