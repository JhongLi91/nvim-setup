function git_setup()
    require("gitsigns").setup({
        current_line_blame = true,
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set("n", "<leader>gr", gs.reset_hunk, opts)
            vim.keymap.set("n", "<leader>gl", function()
                local lnum = vim.fn.line(".")
                gs.reset_hunk({ lnum, lnum })
            end, opts)
        end,
    })

    -- Gitsigns Custom highlights
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#268bd2" })
        end,
    })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#268bd2" })


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

    vim.keymap.set("n", "<leader>gy", ":Gvdiffsplit<CR>", { silent = true, desc = "Fugitive vdiffsplit" })
end
