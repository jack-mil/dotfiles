-- Novel navigation plugin. Get anywhere with `s<char><char>`
return {
  "ggandor/leap.nvim",
  lazy = false,
  config = function() 
    local leap = require("leap")
    leap.create_default_mappings()
    leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
  end,
}
