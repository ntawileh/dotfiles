return {

    {
        "supermaven-inc/supermaven-nvim",
        opts = {
            color = {
                suggestion_color = "#888888",
                cterm = 244,
            },
        },
        -- "supermaven-inc/supermaven-nvim",
        -- config = function()
        --     require("supermaven-nvim").setup({
        --
        --         keymaps = {
        --             accept_suggestion = "<Tab>",
        --             clear_suggestion = "<C-]>",
        --             accept_word = "<C-x>",
        --         },
        --         ignore_filetypes = { cpp = true },
        --         color = {
        --             suggestion_color = "#ee4212",
        --             cterm = 244,
        --         },
        --
        --         log_level = "warn", -- set to "off" to disable logging completely
        --         disable_inline_completion = false, -- disables inline completion for use with cmp
        --         disable_keymaps = false, -- disables built in keymaps for more manual control
        --     })
        -- end,
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
    -- Create annotations with one keybind, and jump your cursor in the inserted annotation
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>cc",
                function()
                    require("neogen").generate({})
                end,
                desc = "Neogen Comment",
            },
        },
        opts = { snippet_engine = "luasnip" },
    },

    -- Incremental rename
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        keys = {
            {
                "<leader>rn",
                function()
                    return ":IncRename " .. vim.fn.expand("<cword>")
                end,
                desc = "Inc Rename",
                mode = "n",
                noremap = true,
                expr = true,
            },
        },
        config = true,
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
    {
        "echasnovski/mini.bracketed",
        event = "BufReadPost",
        config = function()
            local bracketed = require("mini.bracketed")
            bracketed.setup({
                file = { suffix = "" },
                window = { suffix = "" },
                quickfix = { suffix = "" },
                yank = { suffix = "" },
                treesitter = { suffix = "n" },
            })
        end,
    },
    --
    -- Better increase/decrease
    -- {
    --     "monaqa/dial.nvim",
    -- -- stylua: ignore
    -- keys = {
    --   { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
    --   { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    -- },
    --     config = function()
    --         local augend = require("dial.augend")
    --         require("dial.config").augends:register_group({
    --             default = {
    --                 augend.integer.alias.decimal,
    --                 augend.integer.alias.hex,
    --                 augend.date.alias["%Y/%m/%d"],
    --                 augend.constant.alias.bool,
    --                 augend.semver.alias.semver,
    --                 augend.constant.new({ elements = { "let", "const" } }),
    --             },
    --         })
    --     end,
    -- },
    --
    -- {
    --     "simrat39/symbols-outline.nvim",
    --     keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    --     cmd = "SymbolsOutline",
    --     opts = {
    --         position = "right",
    --     },
    -- },
    -- {
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         "hrsh7th/cmp-emoji",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-cmdline",
    --         "rafamadriz/friendly-snippets",
    --     },
    --     sources = {
    --         { name = "path" },
    --         { name = "nvim_lsp", keyword_length = 1 },
    --         { name = "buffer", keyword_length = 3 },
    --         { name = "emoji" },
    --         { name = "luasnip", keyword_length = 2 },
    --         { name = "cmdline", keyword_length = 2 },
    --         { name = "natdat" },
    --     },
    --     ---@param opts cmp.ConfigSchema
    --     opts = function(_, opts)
    --         table.insert(opts.sources, { name = "emoji" })
    --         table.insert(opts.sources, { name = "natdat" })
    --
    --         local has_words_before = function()
    --             unpack = unpack or table.unpack
    --             local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --             return col ~= 0
    --                 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    --         end
    --
    --         local cmp = require("cmp")
    --
    --         opts.mapping = vim.tbl_extend("force", opts.mapping, {
    --
    --             ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    --             ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --             ["<C-Space>"] = cmp.mapping.complete(),
    --             ["<C-e>"] = cmp.mapping.abort(),
    --             ["<CR>"] = cmp.mapping(function(fallback)
    --                 if cmp.visible() then --and cmp.get_active_entry() then
    --                     cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
    --                 else
    --                     fallback()
    --                 end
    --             end, { "i" }),
    --
    --             ["<Tab>"] = cmp.mapping(function(fallback)
    --                 local suggestion = require("supermaven-nvim.completion_preview")
    --
    --                 if suggestion.has_suggestion() then
    --                     LazyVim.create_undo()
    --                     vim.schedule(function()
    --                         suggestion.on_accept_suggestion()
    --                     end)
    --                 elseif cmp.visible() then
    --                     -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
    --                     cmp.confirm({ select = false })
    --                 elseif vim.snippet.active({ direction = 1 }) then
    --                     vim.schedule(function()
    --                         vim.snippet.jump(1)
    --                     end)
    --                 elseif has_words_before() then
    --                     cmp.complete()
    --                 else
    --                     fallback()
    --                 end
    --             end, { "i", "s" }),
    --         })
    --     end,
    -- },
    --
    -- {
    --     "Gelio/cmp-natdat",
    --     ft = { "norg", "org", "markdown" },
    --     opts = { cmp_kind_text = "NatDat" },
    --     config = function(_, opts)
    --         require("cmp_natdat").setup(opts)
    --     end,
    -- },
}
