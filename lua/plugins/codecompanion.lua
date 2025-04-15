return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        strategies = {
            chat = {
                adapter = "gemma3",
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
            gemma3 = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "http://100.64.0.4:11434",
                    },
                    headers = {
                        ["Content-Type"] = "application/json",
                    },
                    schema = {
                        model = {
                            default = "gemma3:12b",
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
