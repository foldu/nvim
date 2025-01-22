return {
    "smoka7/hop.nvim",
    keys = {
        { "gw", "<cmd>HopWord<CR>", desc = "Hop hop" },
    },
    config = function()
        vim.api.nvim_set_hl(
            0,
            "HopNextKey",
            { fg = "#ff007c", bold = true, ctermfg = 198, cterm = { bold = true } }
        )
        vim.api.nvim_set_hl(
            0,
            "HopNextKey1",
            { fg = "#ff007c", bold = true, ctermfg = 198, cterm = { bold = true } }
        )
        vim.api.nvim_set_hl(
            0,
            "HopNextKey2",
            { fg = "#ff007c", bold = true, ctermfg = 198, cterm = { bold = true } }
        )
        -- vim.api.nvim_create_autocmd("ColorScheme", {
        --     callback = function()
        --     end,
        -- })
        require("hop").setup({
            -- keys = "asdfqwexcvghjkluionmb",
            create_hl_autocmd = false,
            dim_unmatched = false,
        })
    end,
}
