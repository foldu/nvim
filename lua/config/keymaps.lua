-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- make visual indenting less ass
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- redo like in helix
-- vim.keymap.set("n", "U", "<C-r>")

-- don't copy empty lines
vim.keymap.set("n", "dd", function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return '"_dd'
    else
        return "dd"
    end
end, { expr = true })

-- don't copy empty lines
vim.keymap.set("n", "cc", function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return [["_cc]]
    else
        return "cc"
    end
end, { expr = true })

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
