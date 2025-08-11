require("config.lazy")
-- must have options
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.scrolloff = 8
vim.o.guifont = "Input Mono 13"
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.undofile = true
vim.o.wrap = false
vim.o.ignorecase = true
vim.o.numberwidth = 4
vim.o.winheight = 10
vim.o.signcolumn = "yes"
vim.o.showtabline = 0

vim.o.list = false
vim.o.listchars = "tab:> ,trail:·,nbsp:+"
vim.opt.fillchars = { eob = " " }

vim.o.cursorline = false

-- cursor
vim.o.guicursor = "n-c-i-ve-ci-v:block,r-cr-o:hor20"

-- indent
-- Default to 4 spaces per tab
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Use 2 spaces per tab for HTML, CSS, and JavaScript
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

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt_local.cindent = true
        vim.opt_local.cinoptions = "l1,(s"
        vim.opt_local.cinwords = "if,else,switch,case,for,while,do"
    end,
})

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

vim.cmd.colorscheme("catppuccin-mocha")
