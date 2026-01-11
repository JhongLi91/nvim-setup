return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    local opts = { buffer = bufnr, noremap = true, silent = true }
                    vim.keymap.set("n", ";gr", gs.reset_hunk, opts)
                    vim.keymap.set("n", ";gl", function()
                        local lnum = vim.fn.line(".")
                        gs.reset_hunk({ lnum, lnum })
                    end, opts)
                end,
            })
            -- Custom highlights
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#268bd2" })
                end,
            })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#268bd2" })
        end
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = function()
            require("git-conflict").setup({
                default_mappings = {
                    ours = "1",
                    theirs = "2",
                    both = "3",
                    none = "4",
                    next = "<C-p>",
                    prev = "<C-n>",
                },
                disable_diagnostics = false,
                list_opener = "copen",
                highlights = {
                    incoming = "DiffAdd",
                    current = "DiffText",
                },
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "GitConflictDetected",
                callback = function()
                    vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
                    vim.keymap.set("n", "cww", function()
                        engage.conflict_buster()
                        create_buffer_local_mappings()
                    end)
                end,
            })
        end
    },
    {
        "tpope/vim-fugitive",
        keys = {
            { ";g", ":Git<CR>",        noremap = true, silent = true },
            { ";y", ":Gvdiffsplit<CR>" },
        }
    },
}
