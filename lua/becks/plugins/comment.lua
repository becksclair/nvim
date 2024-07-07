-- "gc" to comment visual regions/lines
return {
  'numToStr/Comment.nvim',
  lazy = true,
  event = "BufReadPost",
  opts = {
    ignore = nil,

    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      line = '\\',
      block = '|',
    },

    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      line = '\\',
      block = '|',
    },

    extra = {
      above = '<leader>Oc',
      below = '<leader>oc',
      eol = '<leader>Ac',
    },
  },
}
