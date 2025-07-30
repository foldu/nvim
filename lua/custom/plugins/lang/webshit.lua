return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "vue", "css", "html", "javascript", "typescript" } },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                vue_ls = {},
                vtsls = {
                    settings = {
                        tsserver = {
                            globalPlugins = {
                                {
                                    name = "@vue/typescript-plugin",
                                    location = vim.fn.stdpath("data")
                                        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                                    languages = { "vue" },
                                    configNamespace = "typescript",
                                    enableForWorkspaceTypeScriptVersions = true,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
        ft = { "html", "vue", "xml" },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                css = { "prettierd" },
                html = { "prettierd" },
                vue = { "prettierd" },
                yaml = { "prettierd" },
                json = { "prettierd" },
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "prettierd",
                "vtsls",
                "typescript-language-server",
                "vue-language-server",
            },
        },
    },
}
