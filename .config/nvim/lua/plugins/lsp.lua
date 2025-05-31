return {
    -- { "mason-org/mason.nvim", version = "^1.0.0", dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" } },
    -- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
            diagnostics = {
                virtual_text = false,
                underline = true,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                },
            },
            servers = {
                cssls = {
                    settings = {
                        css = {
                            lint = {
                                unknownAtRules = "ignore",
                            },
                        },
                    },
                },
            },
        },
    },
}

-- return {
--     {
--         "mason-org/mason.nvim",
--         dependencies = {
--             "mason-org/mason-lspconfig.nvim",
--             --     "WhoIsSethDaniel/mason-tool-installer.nvim",
--         },
--         config = function()
--             -- import mason
--             local mason = require("mason")
--
--             -- import mason-lspconfig
--             -- local mason_lspconfig = require("mason-lspconfig")
--             --
--             -- local mason_tool_installer = require("mason-tool-installer")
--             --
--             -- enable mason and configure icons
--             mason.setup({
--                 ui = {
--                     icons = {
--                         package_installed = "✓",
--                         package_pending = "➜",
--                         package_uninstalled = "✗",
--                     },
--                 },
--             })
--
--             -- mason_lspconfig.setup({
--             --     -- list of servers for mason to install
--             --     ensure_installed = {
--             --         "html",
--             --         "cssls",
--             --         "tailwindcss",
--             --         "svelte",
--             --         "lua_ls",
--             --         "graphql",
--             --         "emmet_ls",
--             --         "prismals",
--             --         "pyright",
--             --     },
--             -- })
--             --
--             -- mason_tool_installer.setup({
--             --     ensure_installed = {
--             --         "prettier", -- prettier formatter
--             --         "stylua", -- lua formatter
--             --         "isort", -- python formatter
--             --         "black", -- python formatter
--             --         "pylint", -- python linter
--             --         "eslint", -- js linter
--             --         "biome",
--             --     },
--             -- })
--         end,
--     },
--     -- lsp servers
--     {
--         "neovim/nvim-lspconfig",
--         init = function()
--             local keys = require("lazyvim.plugins.lsp.keymaps").get()
--             keys[#keys + 1] = {
--                 "gd",
--                 function()
--                     -- DO NOT REUSE WINDOW
--                     require("telescope.builtin").lsp_definitions({ reuse_win = false })
--                 end,
--                 desc = "Goto Definition",
--                 has = "definition",
--             }
--         end,
--         opts = {
--             inlay_hints = { enabled = false },
--             ---@type lspconfig.options
--             servers = {
--                 eslint = {
--                     settings = {
--                         workingDirectories = { mode = "auto" },
--                         -- rulesCustomizations = {
--                         --     { rule = "style/*", severity = "off", fixable = true },
--                         --     { rule = "format/*", severity = "off", fixable = true },
--                         --     { rule = "*-indent", severity = "off", fixable = true },
--                         --     { rule = "*-spacing", severity = "off", fixable = true },
--                         --     { rule = "*-spaces", severity = "off", fixable = true },
--                         --     { rule = "*-order", severity = "off", fixable = true },
--                         --     { rule = "*-dangle", severity = "off", fixable = true },
--                         --     { rule = "*-newline", severity = "off", fixable = true },
--                         --     { rule = "*quotes", severity = "off", fixable = true },
--                         --     { rule = "*semi", severity = "off", fixable = true },
--                         -- },
--                     },
--                 },
--                 cssls = {
--                     settings = {
--                         css = {
--                             lint = {
--                                 unknownAtRules = "ignore",
--                             },
--                         },
--                     },
--                 },
--                 tailwindcss = {
--                     root_dir = function(...)
--                         return require("lspconfig.util").root_pattern(".git")(...)
--                     end,
--                 },
--                 tsserver = {
--                     root_dir = function(...)
--                         return require("lspconfig.util").root_pattern(".git")(...)
--                     end,
--                     single_file_support = false,
--                     settings = {
--                         typescript = {
--                             inlayHints = {
--                                 includeInlayParameterNameHints = "literal",
--                                 includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--                                 includeInlayFunctionParameterTypeHints = true,
--                                 includeInlayVariableTypeHints = false,
--                                 includeInlayPropertyDeclarationTypeHints = true,
--                                 includeInlayFunctionLikeReturnTypeHints = true,
--                                 includeInlayEnumMemberValueHints = true,
--                             },
--                         },
--                         javascript = {
--                             inlayHints = {
--                                 includeInlayParameterNameHints = "all",
--                                 includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--                                 includeInlayFunctionParameterTypeHints = true,
--                                 includeInlayVariableTypeHints = true,
--                                 includeInlayPropertyDeclarationTypeHints = true,
--                                 includeInlayFunctionLikeReturnTypeHints = true,
--                                 includeInlayEnumMemberValueHints = true,
--                             },
--                         },
--                     },
--                 },
--                 html = {},
--                 yamlls = {
--                     settings = {
--                         yaml = {
--                             keyOrdering = false,
--                         },
--                     },
--                 },
--                 lua_ls = {
--                     -- enabled = false,
--                     single_file_support = true,
--                     settings = {
--                         Lua = {
--                             workspace = {
--                                 checkThirdParty = false,
--                             },
--                             completion = {
--                                 workspaceWord = true,
--                                 callSnippet = "Both",
--                             },
--                             misc = {
--                                 parameters = {
--                                     -- "--log-level=trace",
--                                 },
--                             },
--                             hint = {
--                                 enable = true,
--                                 setType = false,
--                                 paramType = true,
--                                 paramName = "Disable",
--                                 semicolon = "Disable",
--                                 arrayIndex = "Disable",
--                             },
--                             doc = {
--                                 privateName = { "^_" },
--                             },
--                             type = {
--                                 castNumberToInteger = true,
--                             },
--                             diagnostics = {
--                                 disable = { "incomplete-signature-doc", "trailing-space" },
--                                 -- enable = false,
--                                 groupSeverity = {
--                                     strong = "Warning",
--                                     strict = "Warning",
--                                 },
--                                 groupFileStatus = {
--                                     ["ambiguity"] = "Opened",
--                                     ["await"] = "Opened",
--                                     ["codestyle"] = "None",
--                                     ["duplicate"] = "Opened",
--                                     ["global"] = "Opened",
--                                     ["luadoc"] = "Opened",
--                                     ["redefined"] = "Opened",
--                                     ["strict"] = "Opened",
--                                     ["strong"] = "Opened",
--                                     ["type-check"] = "Opened",
--                                     ["unbalanced"] = "Opened",
--                                     ["unused"] = "Opened",
--                                 },
--                                 unusedLocalExclude = { "_*" },
--                             },
--                             format = {
--                                 enable = false,
--                                 defaultConfig = {
--                                     indent_style = "space",
--                                     indent_size = "2",
--                                     continuation_indent_size = "2",
--                                 },
--                             },
--                         },
--                     },
--                 },
--             },
--             setup = {
--                 eslint = function()
--                     local function get_client(buf)
--                         return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
--                     end
--
--                     local formatter = LazyVim.lsp.formatter({
--                         name = "eslint: lsp",
--                         primary = true,
--                         priority = 400,
--                         filter = "eslint",
--                     })
--
--                     -- Use EslintFixAll on Neovim < 0.10.0
--                     if not pcall(require, "vim.lsp._dynamic") then
--                         formatter.name = "eslint: EslintFixAll"
--                         formatter.sources = function(buf)
--                             local client = get_client(buf)
--                             return client and { "eslint" } or {}
--                         end
--                         formatter.format = function(buf)
--                             local client = get_client(buf)
--                             if client then
--                                 local diag =
--                                     vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
--                                 if #diag > 0 then
--                                     vim.cmd("EslintFixAll")
--                                 end
--                             end
--                         end
--                     end
--
--                     -- register the formatter with LazyVim
--                     LazyVim.format.register(formatter)
--                 end,
--                 biome = function() end,
--             },
--         },
--     },
-- {
-- 	"nvimdev/lspsaga.nvim",
-- 	config = function()
-- 		require("lspsaga").setup({})
-- 	end,
-- 	dependencies = {
-- 		"nvim-treesitter/nvim-treesitter", -- optional
-- 		"nvim-tree/nvim-web-devicons", -- optional
-- 	},
-- },
-- }
