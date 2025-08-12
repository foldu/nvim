return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                basedpyright = {},
                ruff = {
                    cmd_env = { RUFF_TRACE = "messages" },
                    init_options = {
                        settings = {
                            logLevel = "error",
                        },
                    },
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "python", "rst" } },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = { "ruff", "basedpyright" },
        },
    },
}
