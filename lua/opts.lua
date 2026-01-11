-- -------------------------------------------------------------------------
-- UI & VISUALS
-- -------------------------------------------------------------------------
vim.opt.number = true        -- Show line numbers
vim.opt.numberwidth = 4      -- Width of the number column
vim.opt.signcolumn = "yes"   -- Always show sign column (prevents text shift)
vim.opt.termguicolors = true -- True color support
vim.opt.showmode = false     -- Don't show mode in command line (lualine handles this)
vim.opt.showtabline = 0      -- Hide tabline
vim.opt.guifont = "Input Mono 13"
vim.opt.guicursor = "n-c-i-ve-ci-v:block,r-cr-o:hor20"
vim.opt.cursorline = false
vim.opt.winheight = 10 -- Min window height

-- Whitespace chars
vim.opt.list = false
vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "+" }
vim.opt.fillchars = { eob = " " } -- Hide ~ at end of buffer
vim.opt.wrap = false

-- -------------------------------------------------------------------------
-- BEHAVIOR & SYSTEM
-- -------------------------------------------------------------------------
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.scrolloff = 8             -- Keep 8 lines above/below cursor
vim.opt.swapfile = false          -- Disable swap files
vim.opt.undofile = true           -- Persistent undo (undo after reopening file)

-- -------------------------------------------------------------------------
-- SEARCH
-- -------------------------------------------------------------------------
vim.opt.hlsearch = true   -- Highlight search results
vim.opt.incsearch = true  -- Show search matches as you type
vim.opt.ignorecase = true -- Ignore case when searching

-- -------------------------------------------------------------------------
-- INDENTATION (Defaults)
-- -------------------------------------------------------------------------
vim.opt.tabstop = 4        -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4     -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4    -- Number of spaces that a <Tab> counts for while editing
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart autoindenting on new lines
vim.opt.autoindent = true  -- Copy indent from current line

-- -------------------------------------------------------------------------
-- AUTOCOMMANDS (Filetype specifics)
-- -------------------------------------------------------------------------

-- Use 2 spaces per tab for Web Development & CMake
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "cmake",
    },
    command = "setlocal tabstop=2 shiftwidth=2",
})

-- Custom C/C++ Indentation
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt_local.cindent = true
        vim.opt_local.cinoptions = "l1,(s"
        vim.opt_local.cinwords = "if,else,switch,case,for,while,do"
    end,
})
