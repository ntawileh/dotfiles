return {
    {
        "EdenEast/nightfox.nvim",
        config = function()
            vim.g.lualine_theme = "nord"
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "nordfox",
        },
    },
}
