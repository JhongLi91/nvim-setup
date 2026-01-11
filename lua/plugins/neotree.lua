return {
    -----------------------------------------------------------------------------
    -- NAVIGATION & FILE MANAGEMENT
    -----------------------------------------------------------------------------
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false, -- Load immediately so it can hijack netrw (nvim .)
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "-", ":Neotree toggle position=current reveal<CR>", silent = true, desc = "Toggle Neo-tree" },
        },
        -- We use a config function to ensure setup runs correctly
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    hijack_netrw_behavior = "open_current",
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "BurntSushi/ripgrep", "nvim-lua/plenary.nvim" },
        config = function()
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
            vim.keymap.set("n", ";f", builtin.find_files)
            vim.keymap.set("n", ";e",
                function() builtin.diagnostics({ severity_limit = vim.diagnostic.severity.ERROR }) end)
            vim.keymap.set("n", ";h", builtin.live_grep)
        end,
    },
    {
        "theprimeagen/harpoon",
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({})
            vim.keymap.set("n", ";a", function() harpoon:list():add() end,
                { silent = true, desc = "Harpoon add file" })
            vim.keymap.set("n", ";w", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { silent = true, desc = "Harpoon quick menu" })
            vim.keymap.set("n", ";1", function() harpoon:list():select(1) end,
                { silent = true, desc = "Harpoon file 1" })
            vim.keymap.set("n", ";2", function() harpoon:list():select(2) end,
                { silent = true, desc = "Harpoon file 2" })
            vim.keymap.set("n", ";3", function() harpoon:list():select(3) end,
                { silent = true, desc = "Harpoon file 3" })
            vim.keymap.set("n", ";4", function() harpoon:list():select(4) end,
                { silent = true, desc = "Harpoon file 4" })
            vim.keymap.set("n", ";5", function() harpoon:list():select(5) end,
                { silent = true, desc = "Harpoon file 5" })
            vim.keymap.set("n", ";6", function() harpoon:list():select(6) end,
                { silent = true, desc = "Harpoon file 6" })
        end
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
        keys = {
            { ";s", function() require("persistence").load() end, desc = "Load Session" }
        }
    },
}
