--insert editing bindings
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-d>", "<delete>")

-- vertical movement
vim.keymap.set("n", "K", "5k", { noremap = true, silent = true })
vim.keymap.set("n", "J", "5j", { noremap = true, silent = true })
vim.keymap.set("v", "K", "5k", { noremap = true, silent = true })
vim.keymap.set("v", "J", "5j", { noremap = true, silent = true })

-- Navigate splits with Ctrl-Shift
vim.keymap.set("n", "<C-S>h", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S>j", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S>k", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S>l", "<C-w>l", { noremap = true, silent = true })
