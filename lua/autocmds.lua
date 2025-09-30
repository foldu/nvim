-- start in insert mode on term open
vim.api.nvim_create_autocmd("TermOpen", {
    command = "startinsert",
})
