return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- Make sure it loads first
        config = function()
            -- 1. Setup the theme
            require("catppuccin").setup({
                flavour = "mocha",
            })
            -- 2. Actually apply it!
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            enabled = true,
            indent = { char = "┆" },
            scope = { enabled = false },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    },
}
