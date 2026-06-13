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

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "only copy to system clipboard on explicit yank",
    callback = function()
        local ok, yank_data = pcall(vim.fn.getreg, [["]])
        if ok and #yank_data > 0 and vim.v.operator == "y" then
            require("vim.ui.clipboard.osc52").copy("+")({ yank_data })
        end
    end,
})

local hl_fun = vim.fn.has("nvim-0.13") and vim.hl.hl_op or vim.highlight.on_yank
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        hl_fun()
    end,
})
