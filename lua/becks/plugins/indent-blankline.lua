return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  lazy = true,
  event = "BufRead",
  enabled = false,
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  opts = {
    char = '┊',
    show_trailing_blankline_indent = true,
  }
}
