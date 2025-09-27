return {
    {
        dir = "~/dev/nvim/mods.nvim",
        config = function()
            require("mods").setup({
                model = "gpt-4.1",
                prompts = {
                    {
                        name = "Caveman",
                        prompt = "re-write this text",
                        role = "caveman",
                    },
                },
            })
            vim.keymap.set({ "v" }, "<leader>aa", function()
                require("mods").query({})
            end, {
                desc = "Query Mods AI with selection as context",
            })

            vim.keymap.set({ "n" }, "<leader>aa", function()
                require("mods").query({})
            end, {
                desc = "Query Mods AI with current buffer as context",
            })

            vim.keymap.set({ "n" }, "<leader>aq", function()
                require("mods").query({
                    exclude_context = true,
                })
            end, {
                desc = "Query Mods AI without buffer context",
            })

            vim.keymap.set({ "n" }, "<leader>ac", function()
                require("mods").get_history()
            end, {
                desc = "View AI recent conversation for this file",
            })
        end,
    },
    {
        "ntawileh/present.nvim",
        dependencies = { "folke/snacks.nvim" },

        -- dir = "~/Documents/dev/nvim/plugins/present.nvim",
        -- config = function()
        --     require("present")
        -- end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },
}
