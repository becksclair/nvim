return {
  'ggandor/leap.nvim',
  lazy = true,
  event = "BufEnter",
  config = function()
    require('leap').add_default_mappings()
  end
}
