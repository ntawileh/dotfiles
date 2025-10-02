if vim.loader then
    vim.loader.enable()
end

_G.dd = function(...)
    Snacks.debug.inspect(...)
end
_G.bt = function()
    Snacks.debug.backtrace()
end
vim.print = _G.dd

require("config.lazy")

-- require("lualine").setup({
-- 	options = {
-- 		theme = "codedark",
-- 		section_separators = "",
-- 		component_separators = "",
-- 	},
-- })

require("ntawileh.formatting")
-- require("ntawileh.supermaven").register_ai_keymaps()

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})

-- vim.diagnostic.config({
--     signs = { priority = 9999 },
--     underline = true,
--     update_in_insert = false, -- false so diags are updated on InsertLeave
--     virtual_text = { current_line = true, severity = { min = "INFO", max = "WARN" } },
--     virtual_lines = { current_line = true, severity = { min = "ERROR" } },
--     severity_sort = true,
--     float = {
--         focusable = false,
--         style = "minimal",
--         border = "rounded",
--         source = true,
--         header = "",
--     },
-- })
