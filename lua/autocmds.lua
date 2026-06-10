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

local lsp_lines_helper = vim.api.nvim_create_augroup("LspLinesHelper", {})
local last_lsp_lines_status = true
vim.api.nvim_create_autocmd("InsertEnter", {
    group = lsp_lines_helper,
    pattern = "*",
    callback = function()
        vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
        last_lsp_lines_status = vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = false,
        })
        -- To update cursor position
        vim.cmd([[ normal "hl" ]])
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = lsp_lines_helper,
    pattern = "*",
    callback = function()
        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = last_lsp_lines_status,
        })
    end,
})
