return {
	"mbbill/undotree",
	cmd = "UndotreeToggle",
	keys = {
		{
			"<leader>cu",
			function()
				vim.cmd("UndotreeToggle")
			end,
			desc = "UndoTree",
		},
	},
}
