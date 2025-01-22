return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ["nixd"] = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                ["nix"] = { "nixfmt" },
            },
        },
    },
}
