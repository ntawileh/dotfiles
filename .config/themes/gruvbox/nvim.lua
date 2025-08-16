return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            vim.g.lualine_colors = "gruvbox_dark"
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "gruvbox",
        },
    },
}
