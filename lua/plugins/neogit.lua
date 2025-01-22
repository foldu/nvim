return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration
    },
    cmd = "Neogit",
    opts = {
        disable_commit_confirmation = true,
    },
    keys = {
        { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
}
