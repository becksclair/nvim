-- "gc" to comment visual regions/lines
return {
  'numToStr/Comment.nvim',
  lazy = true,
  event = "BufReadPost",
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  opts = {
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

    -- Enable nvim-ts-context-commentstring for JSX/TSX and JSONC support
    pre_hook = function(ctx)
      local hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      return hook(ctx) or vim.bo.commentstring
    end,
  },
}
