-- Treesitter based actions
return {
  'echasnovski/mini.nvim',
  lazy = true,
  event = 'BufReadPost',
  version = false,
  config = function()
    require('mini.ai').setup({})
  end
}
