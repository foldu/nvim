-- start in insert mode on term open
vim.api.nvim_create_autocmd("TermOpen", {
    command = "startinsert",
})

local function close_buf(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
        vim.keymap.set("n", "q", function()
            vim.cmd("close")
            pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
        end, {
            buffer = event.buf,
            silent = true,
            desc = "Quit buffer",
        })
    end)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dap-*", "qf", "git", "nvim-undotree", "help" },
    callback = close_buf,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "OilEnter",
    callback = vim.schedule_wrap(function(args)
        local oil = require("oil")
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
            oil.open_preview()
        end
    end),
})
