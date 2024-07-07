return {
  'norcalli/nvim-colorizer.lua',
  lazy = true,
  event = "BufReadPost",
  config = function()
    require('colorizer').setup()
  end,
}
