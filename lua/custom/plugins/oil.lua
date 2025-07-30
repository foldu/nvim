return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
    }
    vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
  end,

  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
