-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- disable swapfiles
vim.o.swapfile = false

-- actually write out files
vim.o.fsync = true

-- better line wrapping
vim.o.linebreak = true
vim.o.wrap = true
vim.o.breakindent = true
vim.o.title = true

vim.g.lazyvim_python_lsp = "basedpyright"

vim.o.complete = ""

vim.o.clipboard = ""

vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
}

vim.o.shiftwidth = 4

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.o.shell = "pwsh"
end
