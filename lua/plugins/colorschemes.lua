return {
    {
        "rebelot/kanagawa.nvim",
        opts = {
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
        },
    },
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "kanagawa",
        },
    },
}
