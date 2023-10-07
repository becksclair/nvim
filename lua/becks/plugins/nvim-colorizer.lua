return {
  'norcalli/nvim-colorizer.lua',
  lazy = true,
  event = "BufEnter",
  config = function()
    require('colorizer').setup()
  end,
}
