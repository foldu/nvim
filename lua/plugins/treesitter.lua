return {
    "nvim-treesitter/nvim-treesitter",
    keys = {
        { "<M-o>", desc = "Increment selection" },
        { "<M-i>", desc = "Decrement selection" },
    },
    opts = {
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<M-o>",
                node_incremental = "<M-o>",
                scope_incremental = false,
                node_decremental = "<M-i>",
            },
        },
    },
}
