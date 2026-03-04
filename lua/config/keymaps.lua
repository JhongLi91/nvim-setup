local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- -------------------------------------------------------------------------
-- NORMAL / VISUAL / OPERATOR MODE
-- -------------------------------------------------------------------------

-- Faster vertical movement (J/K moves 5 lines)
map({ "n", "v" }, "K", "5k", opts)
map({ "n", "v" }, "J", "5j", opts)

-- SCOPE & FUNCTION NAVIGATION
-- -------------------------------------------------------------------------

map({ "n", "v", "o" }, "[[", "[{", opts)
map({ "n", "v", "o" }, "]]", "]}", opts)

map({ "n", "v", "o" }, "[{", "[[", opts)
map({ "n", "v", "o" }, "]}", "]]", opts)
