return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        lazy = false,
        event = "VeryLazy",
        priority = 1000,
        opts = {
            options = {
                -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
                -- You can increase it if you have performance issues.
                -- Or set it to 0 to have better visuals.
                throttle = 20,

                -- The minimum length of the message, otherwise it will be on a new line.
                softwrap = 15,

                -- If multiple diagnostics are under the cursor, display all of them.
                multiple_diag_under_cursor = true,

                show_all_diags_on_cursorline = true,

                --- Enable it if you want to always have message with `after` characters length.
                break_line = {
                    enabled = false,
                    after = 30,
                },

                multilines = true,
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = { diagnostics = { virtual_text = false } },
    },
}
