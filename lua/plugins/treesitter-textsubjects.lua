return {
    "RRethy/nvim-treesitter-textsubjects",
    event = "VeryLazy",
    config = function()
        require("nvim-treesitter.configs").setup({
            textsubjects = {
                enable = true,
                prev_selection = ",", -- (Optional) keymap to select the previous selectiontext
                keymaps = {
                    ["."] = "textsubjects-smart",
                },
            },
        })
    end,
}
