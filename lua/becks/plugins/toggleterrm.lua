return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  event = "VeryLazy",
  version = "*",
  opts = {
    open_mapping = [[<c-\>]],
    -- shade_terminals = true,
    start_in_insert = true,
    direction = 'float',
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = 'rounded',
      -- like `size`, width and height can be a number or function which is passed the current terminal
      -- winblend = 3,
      -- zindex = <value>,
    },
  },
  config = true
}
