return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        { "IndianBoy42/tree-sitter-just" },
    },
    opts = function(_, opts)
        ---@diagnostic disable-next-line: inject-field
        require("nvim-treesitter.parsers").get_parser_configs().just = {
            install_info = {
                url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
                files = { "src/parser.c", "src/scanner.c" },
                branch = "main",
                -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
            },
            maintainers = { "@IndianBoy42" },
        }

        if type(opts.ensure_installed) == "table" then
            vim.list_extend(opts.ensure_installed, { "just" })
        end
    end,
}
