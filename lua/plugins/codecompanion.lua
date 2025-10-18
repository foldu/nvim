vim.pack.add({ { src = "https://github.com/olimorris/codecompanion.nvim" } })

vim.keymap.set(
    { "n", "v" },
    "<C-a>",
    "<cmd>CodeCompanionActions<cr>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    { "n", "v" },
    "<LocalLeader>a",
    "<cmd>CodeCompanionChat Toggle<cr>",
    { noremap = true, silent = true }
)
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

require("codecompanion").setup({
    adapters = {
        http = {
            gpt_oss = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        url = "https://llama.home.5kw.li",
                    },
                    headers = {
                        ["Content-Type"] = "application/json",
                    },
                    schema = {
                        model = {
                            default = "gpt-oss 20B",
                        },
                    },
                })
            end,
        },
    },
    strategies = {
        chat = {
            adapter = "gpt_oss",
        },
    },
    display = {
        chat = {
            window = {
                width = 0.45,
                opts = {
                    number = false,
                    relativenumber = false,
                },
            },
        },
    },
})
