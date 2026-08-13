return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java",
                    "python", "html", "javascript", "typescript", "cmake", "go", "rust"
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = false,
                },
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["}}"] = { query = "@block.outer", desc = "Next block/closure start" },
                        },
                        goto_previous_start = {
                            ["{{"] = { query = "@block.outer", desc = "Previous block/closure start" },
                        },
                    },
                },
            })

            require("treesitter-context").setup({
                max_lines = 1,
            })

            local function setBG(group, bg_color)
                local current_hl = vim.api.nvim_get_hl(0, { name = group, link = false })
                local fg_color = current_hl.fg or "NONE"
                vim.api.nvim_set_hl(0, group, { fg = fg_color, bg = bg_color })
            end

            setBG("TreesitterContextBottom", "#203034")

            vim.keymap.set("n", "<C-z>", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true })
        end,
    },
    {
        "Wansmer/treesj",
        keys = { "<C-m>" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
            })
            vim.keymap.set({ "n", "i" }, "<C-m>", require("treesj").toggle)
            vim.keymap.set({ "n", "i" }, "<C-M>", function()
                require("treesj").toggle({ split = { recursive = true } })
            end)
        end,
    },
}
