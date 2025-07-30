return {
  {
    lazy = true,
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    config = function()
      require('fzf-lua').setup {}
      require('fzf-lua').register_ui_select(function(_, items)
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.60, row = 0.40 } }
      end)
    end,
    keys = {
      { '<leader>/', '<cmd>FzfLua live_grep_native<CR>', desc = 'grep' },
      { '<leader><leader>', '<cmd>FzfLua files<CR>', desc = 'Open file' },
      { '<leader>b', '<cmd>FzfLua buffers<CR>', 'Buffers' },
    },
  },
}
