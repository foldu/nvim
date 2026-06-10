vim.pack.add({
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/tpope/vim-rsi",
})

require("mini.statusline").setup()
require("mini.pairs").setup({ modes = { command = true } })
require("mini.diff").setup({
    view = {
        style = "sign",
    },
})

require("mini.icons").setup({})

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

require("mini.snippets").setup({})

local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
end
require("mini.completion").setup({
    lsp_completion = {
        -- Without this config autocompletion is set up through `:h 'completefunc'`.
        -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
        -- (sets up only when needed) and makes it possible to use `<C-u>`.
        source_func = "omnifunc",
        auto_setup = false,
        process_items = process_items,
    },
})

-- Set 'omnifunc' for LSP completion only when needed.
local on_attach = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
end
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("mini-completion", { clear = true }),
    callback = on_attach,
})

-- Advertise to servers that Neovim now supports certain set of completion and
-- signature features through 'mini.completion'.
vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })

require("mini.keymap").setup()
-- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
MiniKeymap.map_multistep("i", "<Tab>", { "pmenu_next" })
MiniKeymap.map_multistep("i", "<S-Tab>", { "pmenu_prev" })
-- On `<CR>` try to accept current completion item, fall back to accounting
-- for pairs from 'mini.pairs'
MiniKeymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
-- On `<BS>` just try to account for pairs from 'mini.pairs'
MiniKeymap.map_multistep("i", "<BS>", { "minipairs_bs" })

require("mini.pick").setup({})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
    highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

require("mini.trailspace").setup()
