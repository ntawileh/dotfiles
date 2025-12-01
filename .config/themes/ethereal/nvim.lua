return {
    {
        "bjarneo/ethereal.nvim",
        priority = 1000,
        opts = {
            transparent = true,
        },

        config = function(_, opts)
            require("ethereal").setup(opts)
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "ethereal",
        },
    },
}
