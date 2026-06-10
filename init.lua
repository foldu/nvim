-- fasterer lua loading
vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")

require("keymaps")

require("autocmds")

require("plugins")

-- if this kind of looks like a dev machine use lsp
-- root should preferably not download random shit from the internet
-- windows IO is too slow to be usable, so don't create an lsp setup on it
if vim.loop.getuid() ~= 0 and not (vim.fn.has("win32") == 1) and vim.fn.executable("rustup") then
    require("lsp")
end
