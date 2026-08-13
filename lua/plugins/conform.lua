return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    rust = { "rustfmt" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    python = { "ruff_format" },
                    go = { "goimports", "gofmt" },
                    javascript = { "prettierd", "prettier" },
                    html = { "prettierd", "prettier" },
                },
                default_format_opts = { lsp_format = "fallback" },
                format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },
            })

            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
