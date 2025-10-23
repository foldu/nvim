vim.pack.add({
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/rachartier/tiny-glimmer.nvim",
    "https://github.com/rachartier/tiny-code-action.nvim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/OXY2DEV/markview.nvim",
    "https://github.com/sindrets/diffview.nvim",
})

local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})

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

vim.keymap.set({ "v", "n" }, "<leader>fm", function()
    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end)
vim.keymap.set({ "v", "n" }, "<leader>fM", function()
    require("mini.files").open(vim.uv.cwd(), true)
end)

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

vim.keymap.set({ "v", "n" }, "<leader>/", "<cmd>FzfLua live_grep_native<CR>")
vim.keymap.set({ "v", "n" }, "<leader><leader>", "<cmd>FzfLua files<CR>")
vim.keymap.set({ "v", "n" }, "<leader>b", "<cmd>FzfLua buffers<CR>")

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

require("markview").setup({
    preview = {
        icon_provider = "mini",
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
    },
})

require("mini.diff").setup({
    view = {
        style = "sign",
    },
})

vim.o.diffopt = "internal,filler,closeoff,inline:simple,linematch:40"
