return {
  'ggandor/leap.nvim',
  enabled = false,
  lazy = true,
  event = "BufEnter",
  config = function()
    require('leap').add_default_mappings()
  end
}
