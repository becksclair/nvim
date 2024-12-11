-- Treesitter based actions
return {
  'echasnovski/mini.nvim',
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

    require('mini.animate').setup {
      cursor = {
        enable = false,
      },
      scroll = {
        enable = false,
      },
    }

    require('mini.diff').setup {}
  end
}
