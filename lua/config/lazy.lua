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

vim.g.mapleader = ";"
require("plugins.file-explorer")
require("plugins.conform")
require("plugins.git")
require("plugins.lsp")
require("plugins.search")
require("plugins.suggestion")
require("plugins.utils")

require("lazy").setup({
    spec = {
        -- themes
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            config = function()
                require("catppuccin").setup({
                    flavour = "mocha",
                })
                vim.cmd.colorscheme("catppuccin")
            end,
        },
        { "nvim-tree/nvim-web-devicons", lazy = true },

        -- indent
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = {
                enabled = true,
                indent = { char = "┆" },
                scope = { enabled = false },
            },
        },

        -- preview
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = "cd app && yarn install",
            init = function() vim.g.mkdp_filetypes = { "markdown" } end,
            ft = { "markdown" },
        },

        -- treejs
        {
            "Wansmer/treesj",
            keys = { "<C-m>" },
            dependencies = { "nvim-treesitter/nvim-treesitter" },
            config = treejs_setup,
        },

        { "folke/persistence.nvim",      event = "BufReadPost", config = persistence_setup },
        { "rcarriga/nvim-notify",        event = "VeryLazy",    config = notify_setup },

        -- find and replace
        { "nvim-pack/nvim-spectre",      cmd = { "Spectre" },   config = spectre_setup },

        -- LSP
        {
            "neovim/nvim-lspconfig",
            event = "BufReadPre",
            dependencies = {
                "williamboman/mason.nvim",
            },
            config = lsp_setup,
        },

        -- formatter
        { "stevearc/conform.nvim", event = "BufWritePre", opts = {}, config = conform_setup },

        -- File Explorer
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            lazy = false,
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            },
            config = neotree_setup,
        },

        -- completion
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "saadparwaiz1/cmp_luasnip",
                "L3MON4D3/LuaSnip",
                "rafamadriz/friendly-snippets",
                "ray-x/lsp_signature.nvim",
                "nvim-highlight-colors",
            },
            config = suggestion_setup,
        },

        -- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            event = "BufReadPost",
            dependencies = {
                "nvim-treesitter/nvim-treesitter-context",
                "nvim-treesitter/nvim-treesitter-textobjects", -- Add this line!
            },
            config = treesitter_setup,
        },

        -- comment
        { "numToStr/Comment.nvim", event = "VeryLazy",    opts = {}, config = comment_setup },

        -- search
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "folke/todo-comments.nvim",
                "folke/trouble.nvim",
            },
            event = { "BufReadPre" },
            cmd = { "Telescope" },
            config = search_setup,
        },

        -- harpoon
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" },
            event = "VeryLazy",
            config = harpoon_setup,
        },

        -- editing helpers
        { "windwp/nvim-autopairs",    event = "InsertEnter", config = autopairs_setup },
        { "windwp/nvim-ts-autotag",   event = "InsertEnter", config = autotag_setup },
        { "kylechui/nvim-surround",   event = "InsertEnter", config = surround_setup },

        -- status line
        { "nvim-lualine/lualine.nvim" },

        -- git
        {
            "NeogitOrg/neogit",
            event = "VeryLazy",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
                "nvim-telescope/telescope.nvim",
                "lewis6991/gitsigns.nvim",
                "tpope/vim-fugitive",
                { "akinsho/git-conflict.nvim", version = "*" },
            },
            config = git_setup,
        },

        -- jump between variable usages
        {
            "RRethy/vim-illuminate",
            event = "BufReadPost",
            config = illuminate_setup,
        },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = false },
})
