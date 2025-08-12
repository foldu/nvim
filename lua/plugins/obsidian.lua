return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --     -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --     -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --     -- refer to `:h file-pattern` for more examples
    --     "BufReadPre "
    --         .. vim.fn.expand("~")
    --         .. "/src/journal/*.md",
    --     "BufNewFile " .. vim.fn.expand("~") .. "/src/journal/*.md",
    --     "BufReadPre " .. vim.fn.expand("~") .. "/src/lab.home.5kw.li/journal/*.md",
    --     "BufNewFile " .. vim.fn.expand("~") .. "/src/lab.home.5kw.li/journal/*.md",
    -- },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/src/lab.home.5kw.li/journal",
            },
            {
                name = "work",
                path = "~/src/journal",
            },
        },

        -- see below for full list of options 👇
    },
}
