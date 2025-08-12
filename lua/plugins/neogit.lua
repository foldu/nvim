return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    opts = {
        disable_commit_confirmation = true,
    },
    keys = {
        { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
}
