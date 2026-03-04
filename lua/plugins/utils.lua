function harpoon_setup()
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
end

-------------------------------- treesj ---------------------------------

function treejs_setup()
    require("treesj").setup({
        use_default_keymaps = false,
    })
    vim.keymap.set({ "n", "i" }, "<C-m>", require("treesj").toggle)
    vim.keymap.set({ "n", "i" }, "<C-M>", function() require("treesj").toggle({ split = { recursive = true } }) end)
end

----------------------------------------------persistence--------------------------------------------------
function persistence_setup()
    require("persistence").setup()
end

vim.keymap.set("n", ";z", function()
    require("persistence").load()
end)

-------------------------------------------tree-sitter setup--------------------------------------------
function treesitter_setup()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = false,
        },
    })

    require("treesitter-context").setup({
        max_lines = 1,
    })

    local function setBG(group, bg_color)
        local current_hl = vim.api.nvim_get_hl_by_name(group, true)
        local fg_color = current_hl.foreground or "NONE"
        vim.api.nvim_set_hl(0, group, { fg = fg_color, bg = bg_color })
    end
    setBG("TreesitterContextBottom", "#203034")

    vim.keymap.set("n", "<C-h>", function()
        require("treesitter-context").go_to_context(vim.v.count1)
    end, { silent = true })
end

-------------------------------------------comment setup--------------------------------------------------
function comment_setup()
    require("Comment").setup({
        toggler = {
            line = "<C-d>",
        },
        opleader = {
            line = "<C-d>",
        },
    })
end

-------------------------------------------autopairs setup--------------------------------------------
function autopairs_setup()
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

    -- so that {<space> ->  { <cursor> }
    function rule1(a1, ins, a2, lang)
        autopairs.add_rule(Rule(ins, ins, lang)
            :with_pair(function(opts)
                return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
            end)
            :with_move(cond.none())
            :with_cr(cond.none())
            :with_del(function(opts)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                return a1 .. ins .. ins .. a2 ==
                    opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
            end))
    end

    rule1("(", " ", ")")
    rule1("{", " ", "}")
    rule1("[", " ", "]")

    vim.keymap.set("i", "@{<CR>", "{<CR>};<ESC>O", { noremap = true, silent = true })
end

----------------------------------------------replacer setup--------------------------------------------------
function spectre_setup()
    require("spectre").setup()
end

vim.keymap.set("n", ";R", ":Spectre<CR>")
