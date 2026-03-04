function lsp_setup()
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
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            vim.keymap.set("n", ";r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            vim.keymap.set("n", "gu", "<cmd>cexpr []<cr><cmd>lua vim.lsp.buf.references()<cr>", opts)
            vim.keymap.set("n", "L", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
            vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
            vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        end,
    })

    -- Code Action
    vim.keymap.set("n", ";a", vim.lsp.buf.code_action, {})
    vim.keymap.set("v", ";a", function()
        vim.lsp.buf.code_action({ range = vim.api.nvim_buf_get_extmark_by_id(0, "visual_selection", 0, 0, {}) })
    end, {})

    -- Handlers
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

    -- Mason & Server Setup
    require("mason").setup({})
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

    local ls_to_setup = { "pyright", "clangd", "lua_ls", "html", "ts_ls", "cmake", "gopls", "rust_analyzer" }
    for _, server in ipairs(ls_to_setup) do
        vim.lsp.enable(server)
    end
end
