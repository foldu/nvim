return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                tombi = {},
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = { "tombi" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "toml" } },
    },
}
