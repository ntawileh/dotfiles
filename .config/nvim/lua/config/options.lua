vim.g.mapleader = " "

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "fish"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- clipboard
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus" -- use system clipboard as default register
end)

-- turn off swapfile
vim.opt.swapfile = false

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Undercurl
--vim.cmd([[let &t_Cs = "\e[4:3m"]])
--vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.g.ai_cmp = false

-- avoid Biome conflicts with Prettier.
vim.g.lazyvim_prettier_needs_config = true

-- enable exrc
vim.opt.exrc = true

if vim.fn.has("nvim-0.8") == 1 then
    vim.opt.cmdheight = 0
end
