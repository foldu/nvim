return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        strategies = {
            chat = {
                adapter = "qwen2_5_coder",
            },
            inline = {
                adapter = "zeta",
            },
        },
        adapters = {
            zeta = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "http://100.64.0.4:11434",
                    },
                    headers = {
                        ["Content-Type"] = "application/json",
                    },
                    schema = {
                        model = {
                            default = "zeta:7b",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        num_predict = {
                            default = -1,
                        },
                    },
                })
            end,
            qwen2_5_coder = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "http://100.64.0.4:11434",
                    },
                    headers = {
                        ["Content-Type"] = "application/json",
                    },
                    schema = {
                        model = {
                            default = "qwen2.5-coder:14b",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        num_predict = {
                            default = -1,
                        },
                    },
                })
            end,
        },
    },
}
