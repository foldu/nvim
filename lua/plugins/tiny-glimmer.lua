return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration
        overwrite = {
            search = {
                enabled = false,
            },
            undo = {
                enabled = true,
            },
            redo = {
                enabled = true,
            },
            paste = {
                enabled = true,
            },
        },
    },
}
