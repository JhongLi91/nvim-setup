function suggestion_setup()
    local cmp = require("cmp")
    local ls = require("luasnip")

    -- Load VSCode-like snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Setup highlight colors
    require("nvim-highlight-colors").setup({})

    -- Setup nvim-cmp
    cmp.setup({
        formatting = {
            format = require("nvim-highlight-colors").format,
        },
        snippet = {
            expand = function(args) ls.lsp_expand(args.body) end,
        },
        mapping = {
            ["<Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
            ["<Enter>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        performance = {
            debounce = 60,
            throttle = 30,
            fetching_timeout = 200,
            max_view_entries = 4,
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer" },
        }),
    })

    -- Setup LSP signatures
    require("lsp_signature").setup({
        floating_window = true,
        floating_window_above_cur_line = true,
        max_height = 3,
        hint_enable = false,
    })
end
