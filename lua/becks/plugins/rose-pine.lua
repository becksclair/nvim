return {
  'rose-pine/neovim',
  name = 'rose-pine',
  enabled = false,
  lazy = true,
  priority = 1000,
  opts = {
    disable_background = true,
    -- transparent = true
  },
  config = function()
    vim.cmd('colorscheme rose-pine')
  end
}
