-- Statusline plugin
-- TODO: configure more
return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'catppuccin',
            disabled_filetypes = { 'dashboard' },
        },
    },
}

