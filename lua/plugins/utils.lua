return {
    {
        "numToStr/Comment.nvim",
        opts = {
            toggler = { line = "<C-d>" },
            opleader = { line = "<C-d>" },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {
            move_cursor = false,
            keymaps = {
                normal = "vs",
                normal_cur = "vss",
                normal_line = "vS",
                normal_cur_line = "vSS",
                visual = "s",
                visual_line = "gs",
                delete = "ds",
                change = "cs",
                change_line = "cS",
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
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

            -- CMP Integration
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

            -- Custom Rules
            local function rule(a1, ins, a2, lang)
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

            rule("(", " ", ")")
            rule("{", " ", "}")
            rule("[", " ", "]")

            vim.keymap.set("i", "@{<CR>", "{<CR>};<ESC>O", { noremap = true, silent = true })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        lazy = true,
        opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false,
        },
    },
    {
        "nvim-pack/nvim-spectre",
        keys = {
            { ";r", function() require("spectre").open() end, desc = "Open Spectre" },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { ";t", "<CMD>TodoTelescope<CR>",                            desc = "Todo Telescope" },
        }
    },
}
