return {
    {
        dir = "~/Documents/dev/nvim/plugins/mods.nvim",
        config = function()
            require("mods").setup({
                prompts = {
                    {
                        name = "Caveman",
                        prompt = "re-write this text",
                        role = "caveman",
                    },
                },
            })
            vim.keymap.set({ "v", "n" }, "<leader>aa", function()
                require("mods").query({})
            end, {
                desc = "Query Mods AI with selection/buffer as context",
            })

            vim.keymap.set({ "n" }, "<leader>aq", function()
                require("mods").query({
                    exclude_context = true,
                })
            end, {
                desc = "Query Mods AI without context",
            })

            vim.keymap.set({ "n" }, "<leader>ah", function()
                require("mods").get_history()
            end, {
                desc = "View AI conversation history for this file",
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
}
