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
vim.lsp.document_color.enable(true, { "css" }, { style = "virtual" })

-- require("ntawileh.formatting")

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})
