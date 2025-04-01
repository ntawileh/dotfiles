local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
-- keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- -- Split window
-- keymap.set("n", "ss", ":split<Return>", opts)
-- keymap.set("n", "sv", ":vsplit<Return>", opts)
-- -- Move window
-- keymap.set("n", "sh", "<C-w>h")
-- keymap.set("n", "sk", "<C-w>k")
-- keymap.set("n", "sj", "<C-w>j")
-- keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
-- keymap.set("n", "<C-x>", function()
--     vim.diagnostic.goto_next()
-- end, opts)

keymap.set("n", "<leader>rC", function()
    require("ntawileh.hsl").cycleColor()
end, { desc = "Cycle color formats (hex/hsl/rgb)" })

vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename symbol under cursor" })

keymap.set("n", "<leader>i", function()
    require("ntawileh.lsp").hello()
end)

keymap.set("n", "<leader>cL", function()
    require("lint").try_lint()
end, { desc = "Lint current file" })
