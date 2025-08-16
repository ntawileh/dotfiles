return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        ---get attached lsp clients
        ---@return string
        ---
        local function attached_lsp_clients()
            local bufnr = vim.api.nvim_get_current_buf()
            local names = vim.tbl_map(
                ---@param c vim.lsp.Client
                function(c)
                    return c.name
                end,
                vim.lsp.get_clients({ bufnr = bufnr })
            )
            return next(names) and ("󱉶 " .. table.concat(names, ",")) or ""
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
                theme = vim.g.lualine_theme or "auto",
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_a = { { "mode" }, { recording } },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                    { attached_lsp_clients },
                },
            },
        })
    end,
    opts = function(_, opts)
        table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source("supermaven"))
    end,
}
