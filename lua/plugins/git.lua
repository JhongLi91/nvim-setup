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

            vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next Git hunk" })
            vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Previous Git hunk" })
            vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview Git hunk" })
            vim.keymap.set("n", "<leader>ga", gs.stage_hunk, { buffer = bufnr, desc = "Stage Git hunk" })
            vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
        end,
    })

    -- Gitsigns Custom highlights
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
    vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { silent = true, desc = "Open Neogit (Status)" })
    vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { silent = true, desc = "Open Diffview" })
    vim.keymap.set("n", "<leader>gq", ":DiffviewClose<CR>", { silent = true, desc = "Close Diffview" })
    vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { silent = true, desc = "File History (Diffview)" })
end
