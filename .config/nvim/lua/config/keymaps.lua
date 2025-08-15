local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- use jk/kj to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Del marks in buffer
keymap.set("n", "dm`", ":delmarks!<Return>", {
    desc = "Delete all marks in buffer",
})

-- New tab
--keymap.set("n", "<tab>", ":tabnext<Return>", opts)
--keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

keymap.set("n", "<leader>rC", function()
    require("ntawileh.hsl").cycleColor()
end, { desc = "Cycle color formats (hex/hsl/rgb)" })

vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename symbol under cursor" })

keymap.set("n", "<leader>i", function()
    if Snacks.image.supports_terminal() then
        Snacks.image.hover()
    end
end, { desc = "Show image" })

keymap.set("n", "<leader>cL", function()
    require("lint").try_lint()
end, { desc = "Lint current file" })
