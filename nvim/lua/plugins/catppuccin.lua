-- Colortheme
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        flavour = "auto",   -- latte, frappe, macchiato, mocha
        background = {      -- :h background
            light = "latte",
            dark = "mocha",
        },
        dim_inactive = { enabled = false },
        term_colors = true,
        transparent_background = true,
        compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
        default_integrations = false,
        integrations = {
            which_key = true,
            leap = true,
            dashboard = true,
        },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin-frappe")
    end,
}
