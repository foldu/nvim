-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--     vim.o.clipboard = "unnamedplus"
-- end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- disable thing I'm not using anyway
vim.o.complete = ""

-- really make sure editorconfig is enabled
vim.g.editorconfig = true

-- allow vim to set title
vim.o.title = true

-- disable greeting message
vim.o.shortmess = vim.o.shortmess .. "I"

-- i will _not_ press enter to continue
vim.g.messagesopt = "history:500"

-- minimize cmd height
vim.o.cmdheight = 1

-- disable swapfiles they're annoying
vim.o.swapfile = false

-- actually write out files
vim.o.fsync = true

vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Restore cursor to file position in previous editing session",
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})

-- use powerSHIT on windows
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.o.shell = "pwsh"
end

vim.o.guifont = "Maple Mono NL NF CN"

-- make visual indenting less ass
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- redo like in helix
-- vim.keymap.set("n", "U", "<C-r>")

-- properly indent on empty line
-- vim.keymap.set("n", "i", function()
--     if #vim.fn.getline(".") == 0 then
--         return [["_cc]]
--     else
--         return "i"
--     end
-- end, { expr = true })

vim.keymap.set({ "v", "n" }, "H", "^")
vim.keymap.set({ "v", "n" }, "L", "$")

vim.keymap.set({ "v", "n" }, "<leader>y", [["+y]])
vim.keymap.set({ "n" }, "<leader>Y", [["+Y]])
vim.keymap.set({ "v", "n" }, "<leader>p", [["+p]])

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "only copy to system clipboard on explicit yank",
    callback = function()
        local ok, yank_data = pcall(vim.fn.getreg, [["]])
        if ok and #yank_data > 0 and vim.v.operator == "y" then
            require("vim.ui.clipboard.osc52").copy("+")({ yank_data })
        end
    end,
})
