-- Treesitter based actions
return {
  'echasnovski/mini.nvim',
  cond = not require('becks.misc').RunningOnVConsole(),
  lazy = true,
  event = 'BufReadPost',
  version = false,
  config = function()
    require('mini.ai').setup({})
    require('mini.icons').setup {
      style              = 'glyph',

      -- -- Customize per category. See `:h MiniIcons.config` for details.
      -- default            = {},
      -- directory          = {},
      -- extension          = {},
      -- file               = {},
      -- filetype           = {},
      -- lsp                = {},
      -- os                 = {},
      --
      -- -- Control which extensions will be considered during "file" resolution
      -- use_file_extension = function(ext, file) return true end,
    }

    local MiniAnimate = require('mini.animate')

    MiniAnimate.setup {
      cursor = {
        enable = false,
      },
      scroll = {
        enable = false,
      },
      resize = {
        enable = true,
        timing = MiniAnimate.gen_timing.cubic {
          duration = 30,
          easing = 'in',
          unit = 'total'
        },
      }
    }

    require('mini.diff').setup {}
  end
}
