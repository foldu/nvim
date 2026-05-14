-- fasterer lua loading
vim.loader.enable()

vim.pack.add({
    "https://github.com/rebelot/kanagawa.nvim",

    "https://github.com/nvim-mini/mini.nvim",

    "https://github.com/kylechui/nvim-surround",
})

require("mini.statusline").setup()
require('mini.pairs').setup({ modes = { command = true } })
require("mini.diff").setup({
    view = {
        style = "sign",
    }
})

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

vim.pack.add({
    "https://github.com/tpope/vim-rsi",
})
