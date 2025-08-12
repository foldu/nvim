-- stolen from lazyvim
return {
    {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        lazy = false, -- This plugin is already lazy
        ft = { "rust" },
        config = function()
            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {},
                -- LSP configuration
                server = {
                    default_settings = {
                        -- rust-analyzer language server configuration

                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            -- Add clippy lints for Rust if using rust-analyzer
                            checkOnSave = true,
                            -- Enable diagnostics if using rust-analyzer
                            diagnostics = {
                                enable = true,
                            },
                            procMacro = {
                                enable = true,
                            },
                            files = {
                                excludeDirs = {
                                    ".direnv",
                                    ".git",
                                    ".github",
                                    ".gitlab",
                                    "bin",
                                    "node_modules",
                                    "target",
                                    "venv",
                                    ".venv",
                                },
                            },
                        },
                    },
                    -- DAP configuration
                    dap = {},
                },
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "rust" } },
    },
}
