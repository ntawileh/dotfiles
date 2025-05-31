return {
    {
        "supermaven-inc/supermaven-nvim",
        opts = {
            color = {
                suggestion_color = "#888888",
                cterm = 244,
            },
        },
    },
    {
        "saghen/blink.cmp",
        config = {
            completion = {
                list = { selection = { preselect = false, auto_insert = false } },
                ghost_text = {
                    show_with_selection = false,
                },
            },
        },
    },
    -- Refactoring tool
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>r",
                function()
                    require("refactoring").select_refactor()
                end,
                desc = "Refactor",
                mode = "v",
                noremap = true,
                silent = true,
                expr = false,
            },
        },
        opts = {},
    },

    -- Go forward/backward with square brackets
    -- {
    --     "echasnovski/mini.bracketed",
    --     event = "BufReadPost",
    --     config = function()
    --         local bracketed = require("mini.bracketed")
    --         bracketed.setup({
    --             file = { suffix = "" },
    --             window = { suffix = "" },
    --             quickfix = { suffix = "" },
    --             yank = { suffix = "" },
    --             treesitter = { suffix = "n" },
    --         })
    --     end,
    -- },
}
