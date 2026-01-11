return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "folke/trouble.nvim",
        },
        config = function()
            -- Diagnostics Config
            vim.diagnostic.config({
                virtual_text = false,
                severity_sort = true,
                signs = {
                    severity = { min = vim.diagnostic.severity.WARN },
                    text = {
                        [vim.diagnostic.severity.ERROR] = "●",
                        [vim.diagnostic.severity.WARN] = "●",
                        [vim.diagnostic.severity.HINT] = "●",
                        [vim.diagnostic.severity.INFO] = "●",
                    },
                },
                virtual_lines = false,
                underline = false,
                update_in_insert = false,
                float = { border = "rounded" },
            })

            -- Setup Trouble
            require("trouble").setup({
                win = { size = 5 },
                filter = {
                    severity = {
                        min = vim.diagnostic.severity.ERROR,
                        max = vim.diagnostic.severity.ERROR,
                    },
                },
                update_in_insert = true,
            })

            -- Global Hover Function
            _G.hoverLook = function()
                vim.lsp.buf.hover({
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                })
            end

            -- LSP Attach
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "<C-k>", hoverLook, opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gu", "<cmd>cexpr []<cr><cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "L", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
                    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
                    vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
                end,
            })

            -- Handlers
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

            -- Mason & Server Setup
            require("mason").setup({})
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("*", {
                capabilities = capabilities,
                root_markers = { ".git" },
            })

            vim.lsp.config("pyright", {
                settings = {
                    ["python"] = {
                        analysis = {
                            typeCheckingMode = "off",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "openFilesOnly",
                            extraPaths = { "." },
                        },
                    },
                },
            })

            local ls_to_setup = { "pyright", "clangd", "lua_ls", "html", "ts_ls", "cmake" }
            for _, server in ipairs(ls_to_setup) do
                vim.lsp.enable(server)
            end
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "ray-x/lsp_signature.nvim",
            "luckasRanarison/tailwind-tools.nvim",
            "brenoprata10/nvim-highlight-colors",
        },
        config = function()
            local cmp = require("cmp")
            local ls = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("nvim-highlight-colors").setup({})

            cmp.setup({
                formatting = {
                    format = require("nvim-highlight-colors").format,
                },
                snippet = {
                    expand = function(args) ls.lsp_expand(args.body) end,
                },
                mapping = {
                    ["<C-s>"] = cmp.config.disable,
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

            require("lsp_signature").setup({
                floating_window = true,
                floating_window_above_cur_line = true,
                max_height = 3,
                hint_enable = false,
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    python = { "ruff_format" },
                    javascript = { "prettierd", "prettier" },
                    html = { "prettierd", "prettier" },
                },
                default_format_opts = { lsp_format = "fallback" },
                format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
            })
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            vim.api.nvim_set_keymap("n", "==", "gqq", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("v", "=", "gq", { noremap = true, silent = true })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-context" },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java" },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = false },
            })

            require("treesitter-context").setup({ max_lines = 2 })
            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true })
        end
    },
}
