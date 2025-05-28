return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
        },
    },
    keys = {
        { "<leader>O", "<cmd>Oil<CR>", desc = "Oil" },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
