-- Novel navigation plugin. Get anywhere with `s<char><char>`
-- Docs say not use use lazy loading
return {
  {
    'ggandor/leap.nvim',
    lazy = false,
    config = function()
      local leap = require('leap')
      leap.create_default_mappings()
      leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
    end,
  },
  {
    'rasulomaroff/telepath.nvim',
    dependencies = 'ggandor/leap.nvim',
    lazy = false,
    config = function()
      require('telepath').use_default_mappings()
    end,
    -- r - restore or return. Operates on remote textobject and return you back to the initial position.
    -- m - magnet. The same as r, but won't return you back to the initial position.
    -- R - restore recursive. After performing any action, Leap's search mode will be triggered again with the same operator. You can exit this state by pressing escape and you'll be returned to your initial cursor position.
    -- M - same as R, but won't return you to the initial position
  },
}
