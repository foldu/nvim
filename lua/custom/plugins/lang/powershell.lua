return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                powershell_es = {},
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "powershell" } },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = { "powershell-editor-services" },
        },
    },
}
