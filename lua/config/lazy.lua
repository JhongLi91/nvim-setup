-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- themes
        { "catppuccin/nvim",             name = "catppuccin" },
        { "sainnhe/sonokai" },
        { "navarasu/onedark.nvim" },
        { "jacoborus/tender.vim" },
        { "tanvirtin/monokai.nvim" },
        { "morhetz/gruvbox" },
        { "neanias/everforest-nvim" },
        { "ishan9299/nvim-solarized-lua" },
        -- { "projekt0n/github-nvim-theme" },
        { "Mofiqul/vscode.nvim" },
        -- { "folke/tokyonight.nvim" },
        { "rose-pine/neovim",            name = "rose-pine" },

        { "junegunn/vim-easy-align" },

        -- neotree
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
        },

        -- find and replace
        {
            "nvim-pack/nvim-spectre",
        },

        -- install without yarn or npm
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = "cd app && yarn install",
            init = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            ---@module "ibl"
            ---@type ibl.config
            opts = {},
        },

        {
            "Wansmer/treesj",
            dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
        },

        -- peak lines
        {
            "nacro90/numb.nvim",

            config = function()
                require("numb").setup()
            end,
        },

        -- lsp manager
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- base lsp
        { "neovim/nvim-lspconfig" },

        -- completion and suggestions
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip" },
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        {
            "ray-x/lsp_signature.nvim",
            event = "InsertEnter",
        },
        { "luckasRanarison/tailwind-tools.nvim",    lazy = true },
        { "brenoprata10/nvim-highlight-colors",     lazy = true },

        -- formatter
        { "stevearc/conform.nvim",                  opts = {} },

        -- tree-siter
        { "nvim-treesitter/nvim-treesitter" },
        { "nvim-treesitter/nvim-treesitter-context" },

        -- comment
        { "numToStr/Comment.nvim",                  opts = {} },

        -- fuzzy finder
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            dependencies = {
                "BurntSushi/ripgrep",
                "nvim-lua/plenary.nvim",
            },
        },

        -- diagnostcs finder
        { "folke/trouble.nvim" },

        -- todo comments
        { "folke/todo-comments.nvim" },

        -- icons
        { "nvim-tree/nvim-web-devicons" },

        --auto pairs
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true,
        },
        { "windwp/nvim-ts-autotag", lazy = true },

        -- surround editing
        { "kylechui/nvim-surround" },

        -- persistence
        {
            "folke/persistence.nvim",
            event = "BufReadPre", -- this will only start session saving when an actual file was opened
            opts = {
                -- add any custom options here
            },
        },

        -- leetcode
        {
            "kawre/leetcode.nvim",
            dependencies = {
                "nvim-telescope/telescope.nvim",
                -- "ibhagwan/fzf-lua",
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
            },
            opts = {
                -- image_support = true,
                lang = "cpp",
                injector = {
                    cpp = {
                        before = { '#include "headers.hpp"' },
                    },
                },
                storage = {
                    home = "~/cpp/leetcode",
                    cache = vim.fn.stdpath("cache") .. "/leetcode",
                },
            },
        },

        -- harpoon
        { "theprimeagen/harpoon" },

        -- git
        { "lewis6991/gitsigns.nvim",   lazy = true },
        { "akinsho/git-conflict.nvim", version = "*", config = true },
        { "tpope/vim-fugitive" },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = false },
})

----------------------------------------------harpoon setup--------------------------------------------------

local harpoon = require("harpoon")
harpoon:setup({})

vim.keymap.set("n", ";a", function()
    harpoon:list():add()
end, { silent = true, desc = "Harpoon add file" })

vim.keymap.set("n", ";w", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { silent = true, desc = "Harpoon quick menu" })

vim.keymap.set("n", ";1", function()
    harpoon:list():select(1)
end, { silent = true, desc = "Harpoon file 1" })

vim.keymap.set("n", ";2", function()
    harpoon:list():select(2)
end, { silent = true, desc = "Harpoon file 2" })

vim.keymap.set("n", ";3", function()
    harpoon:list():select(3)
end, { silent = true, desc = "Harpoon file 3" })

vim.keymap.set("n", ";4", function()
    harpoon:list():select(4)
end, { silent = true, desc = "Harpoon file 4" })

vim.keymap.set("n", ";5", function()
    harpoon:list():select(5)
end, { silent = true, desc = "Harpoon file 5" })

vim.keymap.set("n", ";6", function()
    harpoon:list():select(6)
end, { silent = true, desc = "Harpoon file 6" })

----------------------------------------------indent setup--------------------------------------------------

require("ibl").setup({
    enabled = true,
    indent = {
        char = "┆",
    },
    scope = {
        enabled = false,
    },
})

----------------------------------------------lsp setup--------------------------------------------------

local tsj = require("treesj")
tsj.setup({
    use_default_keymaps = false,
})
vim.keymap.set("n", "<C-j>", ":lua require('treesj').toggle()<CR>", { silent = true })

----------------------------------------------lsp setup--------------------------------------------------
function hoverLook()
    vim.lsp.buf.hover({
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    })
end

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "<C-k>", hoverLook, opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>cexpr []<cr><cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "L", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    end,
})

-- make hover rounded window
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

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

require("tailwind-tools").setup({})
-----------------------------------------------suggestion setup--------------------------------------------------
local ls = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

require("nvim-highlight-colors").setup({})

local cmp = require("cmp")
cmp.setup({
    formatting = {
        format = require("nvim-highlight-colors").format,
    },
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-s>"] = cmp.config.disable,
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

----------------------------------------------mason setup--------------------------------------------------
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup({})

local servers = { "pyright", "clangd", "lua_ls", "html", "ts_ls", "cmake" }
for _, server in ipairs(servers) do
    lspconfig[server].setup({
        capabilities = capabilities,
    })
end

-------------------------------------------tree-sitter setup--------------------------------------------
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
    max_lines = 2,
})

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-------------------------------------------conform setup--------------------------------------------------
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        python = { "ruff_format" },
        javascript = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_set_keymap("n", "==", "gqq", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "=", "gq", { noremap = true, silent = true })

-------------------------------------------comment setup--------------------------------------------------
require("Comment").setup({
    toggler = {
        line = "<C-d>",
    },
    opleader = {
        line = "<C-d>",
    },
})

-------------------------------------------fuzzy finder setup--------------------------------------------
local telescope = require("telescope")
telescope.setup({
    defaults = {
        layout_config = {
            horizontal = {
                width = 0.90,
                height = 0.95,
                preview_cutoff = 0,
                preview_width = 0.6,
            },
        },
        file_ignore_patterns = {
            ".git/",
            "%.o",
            "%.out",
            "%.dSYM/",
        },
    },
})

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
vim.keymap.set("n", ";f", builtin.find_files)
vim.keymap.set("n", ";e", function()
    builtin.diagnostics({ severity_limit = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", ";h", builtin.live_grep)

require("trouble").setup({
    win = {
        size = 5,
    },
    filter = {
        severity = {
            min = vim.diagnostic.severity.ERROR,
            max = vim.diagnostic.severity.ERROR,
        },
    },
    update_in_insert = true,
})

-------------------------------------------todo setup--------------------------------------------
local todo = require("todo-comments").setup({
    signs = false,
})

vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", ";t", "<CMD>TodoTelescope<CR>")

-------------------------------------------autopairs setup--------------------------------------------
local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

autopairs.setup({
    map_bs = true,             -- map the <BS> key
    map_c_w = true,            -- Map the <C-h> key to delete a pair
    check_ts = true,           -- Enable treesitter integration
    enable_afterquote = false, -- add bracket pairs after quote
    fast_wrap = {
        map = "<C-j>",
        end_key = "l",
        manual_position = false,
        keys = "asdfghjk",
        -- cursor_pos_before = treu,
    },
    ignored_next_char = "[%w%(%{%[%'%\"]",
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

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
--

require("nvim-ts-autotag").setup({
    opts = {
        -- Defaults
        enable_close = true,           -- Auto close tags
        enable_rename = true,          -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
    },
})

-------------------------------------------surround setup--------------------------------------------
require("nvim-surround").setup({
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
})
-------------------------------------------persistence setup--------------------------------------------
-- load the session for the current directory
vim.keymap.set("n", ";s", function()
    require("persistence").load()
end)

-------------------------------------------neotree setup--------------------------------------------
local neotree = require("neo-tree")
neotree.setup({
    filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
            visible = true,
        },
    },
})
vim.keymap.set("n", "-", ":Neotree toggle position=current reveal<CR>", { silent = true })

-------------------------------------------git setup--------------------------------------------
vim.keymap.set("n", ";g", ":Git<CR>", { noremap = true, silent = true })
vim.keymap.set("n", ";y", ":Gvdiffsplit<CR>")

require("gitsigns").setup({
    current_line_blame = true,
    on_attach = function(bufnr)
        local gs = require("gitsigns")
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Normal hunk reset
        vim.keymap.set("n", ";gr", gs.reset_hunk, opts)

        -- Reset only current line
        vim.keymap.set("n", ";gl", function()
            local lnum = vim.fn.line(".")
            gs.reset_hunk({ lnum, lnum })
        end, opts)
    end,
})
require("git-conflict").setup({
    default_mappings = true,     -- disable buffer local mapping created by this plugin
    default_commands = true,     -- disable commands created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    list_opener = "copen",       -- command or function to open the conflicts list
    highlights = {               -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
    },
    default_mappings = {
        ours = "1",
        theirs = "2",
        both = "3",
        none = "4",
        next = "<C-p>",
        prev = "<C-n>",
    },
})

vim.api.nvim_create_autocmd("User", {
    pattern = "GitConflictDetected",
    callback = function()
        vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
        vim.keymap.set("n", "cww", function()
            engage.conflict_buster()
            create_buffer_local_mappings()
        end)
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#268bd2" }) -- light blue
    end,
})

vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#268bd2" })
-------------------------------------------theme setup--------------------------------------------

require("everforest").setup({
    background = "hard",
})

require("vscode").setup({
    style = "dark",
})
