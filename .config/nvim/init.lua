if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
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

require("config.colors")
require("config.formatting")

vim.diagnostic.config({
	virtual_text = false,
	float = {
		border = "rounded",
		source = "always",
	},
})
