-- fasterer lua loading
vim.loader.enable()

vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.notify").setup()
require("mini.icons").setup()
require("mini.ai").setup()
require("mini.statusline").setup()

vim.pack.add({
    -- colorschemes
    { src = "https://github.com/mcauley-penney/techbase.nvim" },
    { src = "https://github.com/rebelot/kanagawa.nvim" },

    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/tpope/vim-rsi" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/rachartier/tiny-glimmer.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/rachartier/tiny-code-action.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mrcjkb/rustaceanvim" },
})

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

require("mason").setup({})

require("mini.files").setup({
    windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
    },
    options = {
        use_as_default_explorer = true,
    },
})

require("nvim-surround").setup()

require("fzf-lua").setup({})
require("fzf-lua").register_ui_select(function(_, items)
    local min_h, max_h = 0.15, 0.70
    local h = (#items + 4) / vim.o.lines
    if h < min_h then
        h = min_h
    elseif h > max_h then
        h = max_h
    end
    return { winopts = { height = h, width = 0.60, row = 0.40 } }
end)

vim.keymap.set({ "v", "n" }, "<leader>fm", function()
    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end)
vim.keymap.set({ "v", "n" }, "<leader>fM", function()
    require("mini.files").open(vim.uv.cwd(), true)
end)
vim.keymap.set({ "v", "n" }, "<leader>/", "<cmd>FzfLua live_grep_native<CR>")
vim.keymap.set({ "v", "n" }, "<leader><leader>", "<cmd>FzfLua files<CR>")
vim.keymap.set({ "v", "n" }, "<leader>b", "<cmd>FzfLua buffers<CR>")

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
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
})

require("tiny-glimmer").setup({
    overwrite = {
        search = {
            enabled = false,
        },
        undo = {
            enabled = true,
        },
        redo = {
            enabled = true,
        },
        paste = {
            enabled = true,
        },
    },
})

require("todo-comments").setup({})

require("nvim-treesitter").setup({
    ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "rust",
        "javascript",
        "typescript",
        "xml",
        "qml",
        "python",
        "ruby",
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
})

require("tiny-code-action").setup({
    --- The backend to use, currently only "vim", "delta", "difftastic", "diffsofancy" are supported
    backend = "difftastic",

    -- The picker to use, "telescope", "snacks", "select" are supported
    -- And it's opts that will be passed at the picker's creation, optional
    -- If you want to use the `fzf-lua` picker, you can simply set it to `select`
    --
    -- You can also set `picker = "telescope"` without any opts.
    picker = {
        "buffer",
        opts = {},
    },
    backend_opts = {
        delta = {
            -- Header from delta can be quite large.
            -- You can remove them by setting this to the number of lines to remove
            header_lines_to_remove = 4,

            -- The arguments to pass to delta
            -- If you have a custom configuration file, you can set the path to it like so:
            -- args = {
            --     "--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
            -- }
            args = {
                "--line-numbers",
            },
        },
        difftastic = {
            header_lines_to_remove = 1,

            -- The arguments to pass to difftastic
            args = {
                "--color=always",
                "--display=inline",
                "--syntax-highlight=on",
            },
        },
        diffsofancy = {
            header_lines_to_remove = 4,
        },
    },

    -- The icons to use for the code actions
    -- You can add your own icons, you just need to set the exact action's kind of the code action
    -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
    signs = {
        quickfix = { "󰁨", { link = "DiagnosticInfo" } },
        others = { "?", { link = "DiagnosticWarning" } },
        refactor = { "", { link = "DiagnosticWarning" } },
        ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
        ["refactor.extract"] = { "", { link = "DiagnosticError" } },
        ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
        ["source.fixAll"] = { "", { link = "DiagnosticError" } },
        ["source"] = { "", { link = "DiagnosticError" } },
        ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
        ["codeAction"] = { "", { link = "DiagnosticError" } },
    },
})

vim.keymap.set({ "v", "n" }, "<leader>gg", "<cmd>Neogit<CR>")
