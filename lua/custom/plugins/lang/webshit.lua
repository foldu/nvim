return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "vue", "css", "html", "javascript", "typescript" } },
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
