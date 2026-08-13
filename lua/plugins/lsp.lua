return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason.nvim",
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

            -- Global Hover Function
            local hover_look = function()
                vim.lsp.buf.hover({
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                })
            end

            -- LSP Attach Keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "<C-f>", hover_look, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                    local function open_def_right_keep_focus()
                        local orig_win = vim.api.nvim_get_current_win()
                        vim.cmd("rightbelow vsplit")
                        vim.lsp.buf.definition()
                        vim.defer_fn(function()
                            if vim.api.nvim_win_is_valid(orig_win) then
                                vim.api.nvim_set_current_win(orig_win)
                            end
                        end, 150)
                    end

                    vim.keymap.set("n", "<C-w>f", open_def_right_keep_focus, opts)

                    -- Code Action
                    vim.keymap.set("n", ";a", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("v", ";a", function()
                        vim.lsp.buf.code_action({ range = vim.api.nvim_buf_get_extmark_by_id(0, "visual_selection", 0, 0, {}) })
                    end, opts)

                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", ";r", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "L", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)

                    vim.keymap.set("n", "gu", function()
                        require("telescope.builtin").lsp_references({
                            include_declaration = true,
                        })
                    end, opts)
                end,
            })

            -- Mason & Native LSP Server Setup
            require("mason").setup({})
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local ls_to_setup = { "pyright", "clangd", "lua_ls", "html", "ts_ls", "cmake", "gopls", "rust_analyzer" }
            for _, server in ipairs(ls_to_setup) do
                local server_config = {
                    capabilities = capabilities,
                }
                if server == "pyright" then
                    server_config.settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "off",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "openFilesOnly",
                                extraPaths = { "." },
                            },
                        },
                    }
                end
                vim.lsp.config(server, server_config)
                vim.lsp.enable(server)
            end
        end,
    },
}
