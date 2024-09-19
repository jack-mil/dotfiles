-- Trim trailing whitespace. Loaded with keybinding
return {
    "cappyzawa/trim.nvim",
    lazy = true,
    keys = {
        { "<leader>oZ", "<cmd>Trim<cr>", mode = "n", desc = "Trim Trailing Whitespace"}
    },
    opts = {
        ft_blocklist  = {"markdown"}, -- don't trim markdown files automatically
        trim_on_write = false,        -- use my own highlighting (looks better)
    }
}