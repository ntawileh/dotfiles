local vault_path = vim.fn.expand("~") .. "/Documents/notes"
local inbox_dir = "0-Inbox"
--
return {
    --"epwalsh/obsidian.nvim",
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        "BufReadPre "
            .. vault_path
            .. "/**.md",
        "BufNewFile " .. vault_path .. "/**.md",
    },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
        -- "hrsh7th/nvim-cmp",
        -- "nvim-telescope/telescope.nvim",
        -- "ibhagwan/fzf-lua",
        -- "nvim-treesitter/nvim-treesitter",
    },

    keys = {
        { "<leader>N", "", desc = "Obsidian" },
        { "<leader>Nd", ":ObsidianToday<cr>", desc = "obsidian [d]aily" },
        { "<leader>Nt", ":ObsidianToday 1<cr>", desc = "obsidian [t]omorrow" },
        { "<leader>Ny", ":ObsidianToday -1<cr>", desc = "obsidian [y]esterday" },
        { "<leader>Nb", ":ObsidianBacklinks<cr>", desc = "obsidian [b]acklinks" },
        { "<leader>Nl", ":ObsidianLink<cr>", desc = "obsidian [l]ink selection" },
        { "<leader>Nf", ":ObsidianFollowLink<cr>", desc = "obsidian [f]ollow link" },
        { "<leader>Nn", ":ObsidianNew<cr>", desc = "obsidian [n]ew" },
        { "<leader>Ns", ":ObsidianSearch<cr>", desc = "obsidian [s]earch" },
        { "<leader>NO", ":ObsidianQuickSwitch<cr>", desc = "obsidian [O]pen quickswitch" },
        { "<leader>No", ":ObsidianOpen<cr>", desc = "obsidian [o]pen in app" },
    },

    cmd = {
        "ObsidianOpen",
        "ObsidianNew",
        "ObsidianQuickSwitch",
        "ObsidianFollowLink",
        "ObsidianBacklinks",
        "ObsidianToday",
        "ObsidianYesterday",
        "ObsidianTemplate",
        "ObsidianSearch",
        "ObsidianLink",
        "ObsidianLinkNew",
    },

    opts = {
        dir = vault_path, -- no need to call 'vim.fn.expand' here
        completion = {
            nvim_cmp = false,
            blink = true,
        },

        daily_notes = {
            folder = "5-Daily",
            template = "t_daily",
            -- Optional, if you want to change the date format for the ID of daily notes.
            -- date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            -- alias_format = "%B %-d, %Y",
        },

        disable_frontmatter = false,

        -- TODO: configure to my liking
        -- Optional, alternatively you can customize the frontmatter data.
        note_frontmatter_func = function(note)
            -- This is equivalent to the default frontmatter function.
            -- local out = { id = note.id, aliases = note.aliases, tags = note.tags }
            -- -- `note.metadata` contains any manually added fields in the frontmatter.
            -- -- So here we just make sure those fields are kept in the frontmatter.
            -- if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
            --   for k, v in pairs(note.metadata) do
            --     out[k] = v
            --   end
            -- end
            -- return out
        end,

        -- Optional, for templates (see below).
        templates = {
            subdir = "meta/templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },

        follow_url_func = function(url)
            vim.fn.jobstart({ "open", url })
        end,

        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        use_advanced_uri = true,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = true,
        ui = {
            enable = false, -- set to false to disable all additional syntax features
            -- update_debounce = 200, -- update delay after a text change (in milliseconds)
            -- -- Define how various check-boxes are displayed
            -- checkboxes = {
            --     -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
            --     [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            --     ["x"] = { char = "", hl_group = "ObsidianDone" },
            --     [">"] = { char = "", hl_group = "ObsidianRightArrow" },
            --     ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
            --     -- Replace the above with this if you don't have a patched font:
            --     -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
            --     -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
            --
            --     -- You can also add more custom ones...
            -- },
            -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            -- -- Replace the above with this if you don't have a patched font:
            -- -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            -- reference_text = { hl_group = "ObsidianRefText" },
            -- highlight_text = { hl_group = "ObsidianHighlightText" },
            -- tags = { hl_group = "ObsidianTag" },
            -- hl_groups = {
            --     -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
            --     ObsidianTodo = { bold = true, fg = "#f78c6c" },
            --     ObsidianDone = { bold = true, fg = "#89ddff" },
            --     ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            --     ObsidianTilde = { bold = true, fg = "#ff5370" },
            --     ObsidianRefText = { underline = true, fg = "#c792ea" },
            --     ObsidianExtLinkIcon = { fg = "#c792ea" },
            --     ObsidianTag = { italic = true, fg = "#89ddff" },
            --     ObsidianHighlightText = { bg = "#75662e" },
            -- },
        },

        attachments = {
            img_folder = "meta/attachments",
        },
        statusline = {
            enabled = true,
            format = " {{properties}} 󰌷 {{backlinks}} 󰆙 {{words}}/{{chars}}",
        },

        new_notes_location = "notes_subdir",

        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. "-" .. suffix
        end,

        -- Optional, customize how note file names are generated given the ID, target directory, and title.
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
            -- This is equivalent to the default behavior.
            local path = spec.dir / inbox_dir / tostring(spec.id)
            -- local path = vault_path / inbox_dir / tostring(spec.id)
            return path:with_suffix(".md")
        end,

        picker = {
            name = "snacks.pick",
        },
    },

    mappings = {
        --   ["gf"] = require("obsidian.mapping").gf_passthrough(),
        --   -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
            action = function()
                return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
            action = function()
                return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        },
    },

    config = function(_, opts)
        require("obsidian").setup(opts)
        vim.opt.conceallevel = 1
        vim.keymap.set("n", "gd", function()
            if require("obsidian").util.cursor_on_markdown_link() then
                return "<cmd>ObsidianFollowLink<CR>"
            else
                return "gd"
            end
        end, { noremap = false, expr = true })
    end,
}
