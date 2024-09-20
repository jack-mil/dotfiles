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
        transparent_background = true,
        compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
        integrations = {
            barbecue = {
                dim_dirname = true, -- directory name is dimmed by default
                bold_basename = true,
                dim_context = false,
                alt_background = false,
            },
        },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin-frappe")
    end,
}
