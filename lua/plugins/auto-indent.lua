return {
    {
        "vidocqh/auto-indent.nvim",
        opts = {
            indentexpr = function(lnum)
                return require("nvim-treesitter.indent").get_indent(lnum)
            end,
        },
    },
}
