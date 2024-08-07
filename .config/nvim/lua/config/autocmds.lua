-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 1
	end,
})

-- Disable the autoformatting for JavaScript and TypeScript -
-- and use the eslint fix all instead
vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
	callback = function()
		print("Setting autoformat to false")
		vim.b.autoformat = false
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
	command = "silent! EslintFixAll",
	group = vim.api.nvim_create_augroup("AutocmdsJavaScripFormatting", {}),
})
