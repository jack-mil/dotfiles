-- Novel navigation plugin. Get anywhere with `s<char><char>`
-- Docs say not use use lazy loading
return {
  {
    'ggandor/leap.nvim',
    lazy = false,
    config = function()
      local leap = require('leap')
      -- leap.set_default_mappings() -- Set in keymaps
      leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
      -- filter whitespace and middle of words from first label preview
      leap.opts.preview_filter = function(ch0, ch1, ch2)
        return not (
          ch1:match('%s') or
          ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
        )
      end
    end,
  },
  {
    'rasulomaroff/telepath.nvim',
    dependencies = 'ggandor/leap.nvim',
    enabled = false, -- no longer needed with recent leap.nvim additions
    lazy = false,
    config = function()
      require('telepath').use_default_mappings()
    end,
    -- r - restore or return. Operates on remote text object and return you back to the initial position.
    -- m - magnet. The same as r, but won't return you back to the initial position.
    -- R - restore recursive. After performing any action, Leap's search mode will be triggered again with the same operator. You can exit this state by pressing escape and you'll be returned to your initial cursor position.
    -- M - same as R, but won't return you to the initial position
  },
}
