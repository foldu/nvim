-- fasterer lua loading
vim.loader.enable()

vim.pack.add({
    -- colorschemes
    "https://github.com/mcauley-penney/techbase.nvim",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/wurli/cobalt.nvim",

    "https://github.com/nvim-mini/mini.nvim",
})

require("mini.notify").setup()
require("mini.icons").setup()
require("mini.ai").setup()
-- require("mini.statusline").setup()

require("kanagawa").setup({
    compile = true,
    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = "none",
                },
            },
        },
    },
})
vim.cmd.colorscheme("kanagawa")

vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/tpope/vim-rsi",
    "https://github.com/windwp/nvim-autopairs",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mrcjkb/rustaceanvim",
})

require("ui")

require("treesitter")

require("plugins/codecompanion")

require("plugins/opencode")

require("mason").setup({})

require("nvim-surround").setup()

require("nvim-autopairs").setup()

require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
    keymap = {
        preset = "enter",
        -- ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },

    cmdline = {
        keymap = {
            preset = "inherit",
            ["<CR>"] = { "accept_and_enter", "fallback" },
        },
    },

    sources = {
        default = { "lsp", "path", "snippets" },
    },
})

require("conform").setup({
    notify_on_error = false,
    format_on_save = function(_)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        return {
            timeout_ms = 500,
            lsp_format = "fallback",
        }
    end,
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff" },
        nix = { "nixfmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
    },
})
