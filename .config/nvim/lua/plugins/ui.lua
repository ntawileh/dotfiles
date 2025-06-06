return {
    -- messages, cmdline and the popupmenu
    {
        "folke/noice.nvim",
        opts = function(_, opts)
            table.insert(opts.routes, {
                filter = {
                    event = "notify",
                    find = "No information available",
                },
                opts = { skip = true },
            })
            local focused = true
            vim.api.nvim_create_autocmd("FocusGained", {
                callback = function()
                    focused = true
                end,
            })
            vim.api.nvim_create_autocmd("FocusLost", {
                callback = function()
                    focused = false
                end,
            })
            table.insert(opts.routes, 1, {
                filter = {
                    cond = function()
                        return not focused
                    end,
                },
                view = "notify_send",
                opts = { stop = false },
            })

            opts.commands = {
                all = {
                    -- options for the message history that you get with `:Noice`
                    view = "split",
                    opts = { enter = true, format = "details" },
                    filter = {},
                },
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function(event)
                    vim.schedule(function()
                        require("noice.text.markdown").keys(event.buf)
                    end)
                end,
            })

            opts.presets.lsp_doc_border = true
        end,
    },

    -- buffer line
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
            { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        },
        opts = {
            options = {
                mode = "tabs",
                separator_style = "slant",
                -- show_buffer_close_icons = false,
                -- show_close_icon = false,
            },
        },
    },

    -- filename
    {
        "b0o/incline.nvim",
        dependencies = { "catppuccin" },
        event = "BufReadPre",
        priority = 1200,
        config = function()
            local colors = require("catppuccin.palettes").get_palette("mocha")
            require("incline").setup({
                highlight = {
                    groups = {
                        InclineNormal = { guibg = colors.base, guifg = colors.pink },
                        InclineNormalNC = { guifg = colors.mauve, guibg = colors.base },
                    },
                },
                window = { margin = { vertical = 0, horizontal = 1 } },
                hide = {
                    cursorline = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if vim.bo[props.buf].modified then
                        filename = "[+] " .. filename
                    end

                    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                    return { { icon, guifg = color }, { " " }, { filename } }
                end,
            })
        end,
    },

    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            plugins = {
                gitsigns = true,
                tmux = true,
                kitty = { enabled = false, font = "+2" },
            },
        },
        keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    },
    {
        "folke/snacks.nvim",
        opts = {
            notifier = {
                enabled = true,
            },
            image = {
                doc = {
                    enable = true,
                    inline = false,
                    float = false,
                },
            },
            dashboard = {
                sections = {

                    { section = "header" },
                    {
                        pane = 2,
                        section = "terminal",
                        cmd = "~/.config/nt/color/shell-color-scripts/colorscript.sh -e crunchbang-mini",
                        height = 10,
                        padding = 1,
                    },
                    { section = "keys", gap = 1, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                    },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = vim.fn.isdirectory(".git") == 1,
                        cmd = "git status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
                preset = {
                    header = [[
    ██╗  ██╗██╗    ███╗   ██╗ █████╗ ██████╗ ██╗███╗   ███╗
    ██║  ██║██║    ████╗  ██║██╔══██╗██╔══██╗██║████╗ ████║
    ███████║██║    ██╔██╗ ██║███████║██║  ██║██║██╔████╔██║
    ██╔══██║██║    ██║╚██╗██║██╔══██║██║  ██║██║██║╚██╔╝██║
    ██║  ██║██║    ██║ ╚████║██║  ██║██████╔╝██║██║ ╚═╝ ██║
    ╚═╝  ╚═╝╚═╝    ╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝     ╚═╝
]],

--
--      .-') _    ('-.     _ .-') _           _   .-')
--     ( OO ) )  ( OO ).-.( (  OO) )         ( '.( OO )_
-- ,--./ ,--,'   / . --. / \     .'_   ,-.-') ,--.   ,--.)
-- |   \ |  |\   | \-.  \  ,`'--..._)  |  |OO)|   `.'   |
-- |    \|  | ).-'-'  |  | |  |  \  '  |  |  \|         |
-- |  .     |/  \| |_.'  | |  |   ' |  |  |(_/|  |'.'|  |
-- |  |\    |    |  .-.  | |  |   / : ,|  |_.'|  |   |  |
-- |  | \   |    |  | |  | |  '--'  /(_|  |   |  |   |  |
-- `--'  `--'    `--' `--' `-------'   `--'   `--'   `--'
--  ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
                },
            },
        },
        keys = {
            {
                "<leader>fs",
                function()
                    Snacks.picker.smart()
                end,
                desc = "Smart Find Files",
            },
        },
    },

    --   ██╗  ██╗██╗    ███╗   ██╗ █████╗ ██████╗ ██╗███╗   ███╗
    --   ██║  ██║██║    ████╗  ██║██╔══██╗██╔══██╗██║████╗ ████║
    --   ███████║██║    ██╔██╗ ██║███████║██║  ██║██║██╔████╔██║
    --   ██╔══██║██║    ██║╚██╗██║██╔══██║██║  ██║██║██║╚██╔╝██║
    --   ██║  ██║██║    ██║ ╚████║██║  ██║██████╔╝██║██║ ╚═╝ ██║
    --   ╚═╝  ╚═╝╚═╝    ╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝     ╚═╝
    --
    --
}
