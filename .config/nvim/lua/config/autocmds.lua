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
-- vim.api.nvim_create_autocmd("BufRead", {
-- 	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
-- 	callback = function()
-- 		print("Setting autoformat to false")
-- 		vim.b.autoformat = false
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
-- 	command = "silent! EslintFixAll",
-- 	group = vim.api.nvim_create_augroup("AutocmdsJavaScripFormatting", {}),
-- })
--

-- Show diag on current line only
-- local ns = vim.api.nvim_create_namespace("CurlineDiag")
-- vim.opt.updatetime = 100
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(args)
-- 		vim.api.nvim_create_autocmd("CursorHold", {
-- 			buffer = args.buf,
-- 			callback = function()
-- 				pcall(vim.api.nvim_buf_clear_namespace, args.buf, ns, 0, -1)
-- 				local hi = { "Error", "Warn", "Info", "Hint" }
-- 				local curline = vim.api.nvim_win_get_cursor(0)[1]
-- 				local diagnostics = vim.diagnostic.get(args.buf, { lnum = curline - 1 })
-- 				local virt_texts = { { (" "):rep(4) } }
-- 				for _, diag in ipairs(diagnostics) do
-- 					virt_texts[#virt_texts + 1] = { diag.message, "Diagnostic" .. hi[diag.severity] }
-- 				end
-- 				vim.api.nvim_buf_set_extmark(args.buf, ns, curline - 1, 0, {
-- 					virt_text = virt_texts,
-- 					hl_mode = "combine",
-- 				})
-- 			end,
-- 		})
-- 	end,
-- })
