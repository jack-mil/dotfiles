return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },

  cmd = 'Neotree',

  opts = {
    source_selector = {
      winbar = true,
      content_layout = 'center',
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

    -- Show hidden items dimmly
    filesystem = { filtered_items = { visible = true } },

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
          else -- if expanded and has children, seleect the next child
            if node.type == 'file' then
              state.commands.open(state)
            else
              require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
            end
          end
        else -- if has no children
          state.commands.open(state)
        end
      end,
    },
  },
}
