return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
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
