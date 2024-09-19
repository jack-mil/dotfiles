return {
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle", "ColorizerReloadAllBuffers", "ColorizerDetachFromBuffer", "ColorizerAttachToBuffer"},
    -- event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return {'*'; css = { css = true, names = true, RRGGBBAA = true } }, -- enable on all filetypes, more patterns for css
             { RGB = false, names = false, css = false }                 -- disable patterns by default
    end,
}
