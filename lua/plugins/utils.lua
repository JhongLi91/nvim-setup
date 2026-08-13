return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({})

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { silent = true, desc = "Harpoon add file" })
            vim.keymap.set("n", "<leader>w", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { silent = true, desc = "Harpoon quick menu" })
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { silent = true, desc = "Harpoon file 1" })
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { silent = true, desc = "Harpoon file 2" })
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { silent = true, desc = "Harpoon file 3" })
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { silent = true, desc = "Harpoon file 4" })
            vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { silent = true, desc = "Harpoon file 5" })
            vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, { silent = true, desc = "Harpoon file 6" })
            vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, { silent = true, desc = "Harpoon file 7" })
        end,
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPost",
        config = function()
            require("persistence").setup()
            vim.keymap.set("n", ";z", function()
                require("persistence").load()
            end)
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup({
                toggler = {
                    line = "<C-d>",
                },
                opleader = {
                    line = "<C-d>",
                },
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")

            autopairs.setup({
                map_bs = true,
                map_c_w = true,
                check_ts = true,
                enable_afterquote = false,
                fast_wrap = {
                    map = "<C-j>",
                    end_key = "l",
                    manual_position = false,
                    keys = "asdfghjk",
                },
                ignored_next_char = "[%w%(%{%[%'%\"]",
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

            local function rule1(a1, ins, a2, lang)
                autopairs.add_rule(Rule(ins, ins, lang)
                    :with_pair(function(opts)
                        return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
                    end)
                    :with_move(cond.none())
                    :with_cr(cond.none())
                    :with_del(function(opts)
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        return a1 .. ins .. ins .. a2 ==
                            opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2)
                    end))
            end

            rule1("(", " ", ")")
            rule1("{", " ", "}")
            rule1("[", " ", "]")

            vim.keymap.set("i", "@{<CR>", "{<CR>};<ESC>O", { noremap = true, silent = true })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        event = "InsertEnter",
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    },
    {
        "RRethy/vim-illuminate",
        event = "BufReadPost",
        config = function()
            require("illuminate").configure({
                providers = { "lsp", "treesitter", "regex" },
                delay = 200,
                filetypes_denylist = {
                    "dirbuf", "dirvish", "fugitive", "TelescopePrompt", "qf"
                },
            })

            vim.keymap.set({ "n" }, "]u", function()
                require("illuminate").goto_next_reference(true)
            end, { desc = "Next Variable Usage" })

            vim.keymap.set({ "n" }, "[u", function()
                require("illuminate").goto_prev_reference(true)
            end, { desc = "Previous Variable Usage" })
        end,
    },
}
