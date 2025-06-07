-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Auto resize splits when the terminal's window is resized",
    command = "wincmd =",
})

-- https://old.reddit.com/r/neovim/comments/1l4tubm/copy_last_yanked_text_to_clipboard_on_focuslost/
vim.api.nvim_create_autocmd("FocusLost", {
    desc = "Copy to clipboard on FocusLost",
    callback = function()
        vim.fn.setreg("+", vim.fn.getreg("0"))
    end,
})
