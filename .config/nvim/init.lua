if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

require("lualine").setup({
	options = {
		theme = "codedark",
		section_separators = "",
		component_separators = "",
	},
})

require("config/colors")
