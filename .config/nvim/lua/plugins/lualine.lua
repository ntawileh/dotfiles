return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        local colors = {
            blue = "#8AADF4",
            green = "#A6DA95",
            violet = "#b7bdf8",
            yellow = "#EED49F",
            red = "#ED8796",
            orange = "#F5A97F",
            fg = "#c3ccdc",
            bg = "#112638",
            inactive_bg = "#2c3043",
        }

        local my_lualine_theme = {
            normal = {
                a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            insert = {
                a = { bg = colors.green, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            visual = {
                a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            command = {
                a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            replace = {
                a = { bg = colors.red, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            inactive = {
                a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.semilightgray },
                c = { bg = colors.inactive_bg, fg = colors.semilightgray },
            },
        }

        ---get attached lsp clients
        ---@return string
        local function attached_lsp_clients()
            local clients = {}
            for _, client in pairs(vim.lsp.buf_get_clients()) do
                table.insert(clients, client.name)
            end
            if #clients == 0 then
                return ""
            else
                return "󱉶 " .. table.concat(clients, ",")
            end
        end

        ---check if we are recording and return status
        ---@return string
        local function recording()
            if vim.fn.reg_recording() ~= "" then
                return "Recording @" .. vim.fn.reg_recording()
            else
                return ""
            end
        end
        -- configure lualine with modified theme
        lualine.setup({

            options = {
                theme = my_lualine_theme,
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_a = { { "mode" }, { recording, color = { fg = colors.red, bg = colors.bg } } },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = colors.orange },
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                    { attached_lsp_clients },
                },
            },
        })
    end,
}
