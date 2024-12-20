return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  -- lazy load when using command
  cmd = 'Neotree',
  init = function() -- to allow lazy-loading + opening directories
    vim.api.nvim_create_autocmd('BufEnter', {
      -- make a group to be able to delete it later
      group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
      callback = function()
        local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))
        if stats and stats.type == 'directory' then
          require('lazy').load({ plugins = { 'neo-tree.nvim' } })
          -- neo-tree is loaded now, delete the init autocmd
          vim.api.nvim_clear_autocmds({ group = 'NeoTreeInit' })
        end
      end,
    })
  end,
  opts = {
    enable_git_stats = vim.fn.executable('git') == 1,
    auto_clean_after_session_restore = true,
    enable_cursor_hijack = true,
    source_selector = {
      winbar = true,
      tabs_layout = 'start',
      show_scrolled_off_parent_node = true,
      sources = {
        { source = 'filesystem', display_name = 'File' },
        { source = 'buffers', display_nam = 'Bufs' },
        { source = 'git_status', display_name = 'Git' },
      },
    },

    window = {
      width = 35,
      mappings = {
        ['<space>'] = false, -- unbind confict with <leader>
        ['<S-CR>'] = 'system_open',
        ['[b'] = 'prev_source',
        [']b'] = 'next_source',
        ['O'] = 'system_open',
        ['h'] = 'parent_or_close',
        ['l'] = 'child_or_open',
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ['<C-J>'] = 'move_cursor_down',
        ['<C-K>'] = 'move_cursor_up',
      },
    },

    filesystem = {
      filtered_items = {
        visible = true,
        never_show_by_pattern = { '__pycache__/' },
      }, -- Show hidden items dimmly (some)
      group_empty_dirs = true,
      hijack_netrw_behaviour = 'open_current',
      use_libuv_file_watcher = vim.fn.has('win32') ~= 1,
    },

    event_handlers = {
      {
        -- Disable gutter columns on enter
        event = 'neo_tree_buffer_enter',
        handler = function(_)
          vim.opt_local.signcolumn = 'auto'
          vim.opt_local.foldcolumn = '0'
        end,
      },
    },

    commands = {
      -- Open with system default filetype
      system_open = function(state)
        vim.ui.open(state.tree:get_node():get_id())
      end,
      -- Open files without losing focus
      quick_open = function(state)
        local node = state.tree:get_node()
        if require('neo-tree.utils').is_expandable(node) then
          state.commands['toggle_node'](state)
        else
          state.commands['open'](state)
          vim.cmd('Neotree reveal')
        end
      end,
      -- Move up and collapse nodes
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if node:has_children() and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
        end
      end,

      -- Move down and expand nodes/open file
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else -- if expanded and has children, select the next child
            if node.type == 'file' then
              state.commands.open(state)
              -- vim.cmd('Neotree reveal')
            else
              require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
            end
          end
        else -- if has no children
          state.commands.open(state)
          -- vim.cmd('Neotree reveal')
        end
      end,
    },
  },
}
