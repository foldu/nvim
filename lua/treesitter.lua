vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/MeanderingProgrammer/treesitter-modules.nvim" },
})

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
        "cmake",
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

require("treesitter-modules").setup({
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<A-o>",
            node_incremental = "<A-o>",
            scope_incremental = "<A-O>",
            node_decremental = "<A-i>",
        },
    },
})
