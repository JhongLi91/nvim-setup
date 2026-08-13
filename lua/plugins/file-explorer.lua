return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set("n", "-", ":Neotree toggle position=current reveal<CR>", { silent = true, desc = "Toggle Neo-tree" })

            require("neo-tree").setup({
                filesystem = {
                    hijack_netrw_behavior = "open_current",
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
            })
        end,
    },
}
