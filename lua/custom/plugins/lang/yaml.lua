return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "b0o/SchemaStore.nvim",
                lazy = true,
                version = false, -- last release is way too old
            },
        },
        opts = {
            servers = {
                yamlls = {
                    capabilities = {
                        textDocument = {
                            foldingRange = {
                                dynamicRegistration = false,
                                lineFoldingOnly = true,
                            },
                        },
                    },
                    on_new_config = function(new_config)
                        new_config.settings.yaml.schemas = vim.tbl_deep_extend(
                            "force",
                            new_config.settings.yaml.schemas or {},
                            require("schemastore").yaml.schemas()
                        )
                    end,
                    settings = {
                        redhat = { telemetry = { enabled = false } },
                        yaml = {
                            keyOrdering = false,
                            validate = true,
                            schemaStore = {
                                -- Must disable built-in schemaStore support to use
                                -- schemas from SchemaStore.nvim plugin
                                enable = false,
                                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                url = "",
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "yaml" } },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = { "yaml-language-server", "prettierd" },
        },
    },
}
