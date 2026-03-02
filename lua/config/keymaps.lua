local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- -------------------------------------------------------------------------
-- INSERT MODE
-- -------------------------------------------------------------------------

-- Fast navigation in insert mode
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-d>", "<Delete>", opts) -- Fixed capitalization of <Delete>

-- -------------------------------------------------------------------------
-- NORMAL / VISUAL MODE
-- -------------------------------------------------------------------------

-- Faster vertical movement (J/K moves 5 lines)
map({ "n", "v" }, "K", "5k", opts)
map({ "n", "v" }, "J", "5j", opts)

-- -------------------------------------------------------------------------
-- WINDOW NAVIGATION
-- -------------------------------------------------------------------------

-- Navigate splits with Ctrl+Shift+Direction
-- Note: Some terminals capture Ctrl+Shift shortcuts.
-- If these don't work, check your terminal emulator settings.
map("n", "<C-S>h", "<C-w>h", opts)
map("n", "<C-S>j", "<C-w>j", opts)
map("n", "<C-S>k", "<C-w>k", opts)
map("n", "<C-S>l", "<C-w>l", opts)
