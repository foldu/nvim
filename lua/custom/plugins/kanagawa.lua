return {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
        require("kanagawa").setup({
            compile = true,
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
        })
        vim.cmd.colorscheme("kanagawa")
    end,
}
