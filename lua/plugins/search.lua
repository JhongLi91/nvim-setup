function search_setup()
    local telescope = require("telescope")

    telescope.setup({
        defaults = {
            layout_config = {
                horizontal = {
                    width = 0.90,
                    height = 0.95,
                    preview_cutoff = 0,
                    preview_width = 0.6,
                },
            },
            file_ignore_patterns = { ".git/", "%.o", "%.out", "%.dSYM/" },
        },
    })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>f", builtin.find_files)
    vim.keymap.set("n", "<leader>e", function()
        builtin.diagnostics({ severity_limit = vim.diagnostic.severity.ERROR })
    end)
    vim.keymap.set("n", "<leader>h", builtin.live_grep)
end
