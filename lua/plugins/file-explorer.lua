function neotree_setup()
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
end
