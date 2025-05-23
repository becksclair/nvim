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
      style = 'glyph',

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
          easing   = 'in',
          unit     = 'total'
        },
      }
    }

    require('mini.diff').setup {}

    require('mini.surround').setup {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add            = 'gsa', -- Add       surrounding in     Normal and    Visual modes
        delete         = 'gsd', -- Delete    surrounding
        find           = 'gsf', -- Find      surrounding (to    the    right)
        find_left      = 'gsF', -- Find      surrounding (to    the    left)
        highlight      = 'gsh', -- Highlight surrounding
        replace        = 'gsr', -- Replace   surrounding
        update_n_lines = 'gsn', -- Update    `n_lines`

        suffix_last    = 'l',   -- Suffix    to          search with   "prev" method
        suffix_next    = 'n',   -- Suffix    to          search with   "next" method
      },

      -- Number of lines within which surrounding is searched
      n_lines = 20,

      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = 'cover',

      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    }

    require('mini.align').setup {}
  end
}
