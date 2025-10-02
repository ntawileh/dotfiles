return {
    {
        "saghen/blink.cmp",
        config = {
            completion = {
                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = false,
                    },
                },
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
}
