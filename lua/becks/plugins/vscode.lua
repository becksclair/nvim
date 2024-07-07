return {
  'Mofiqul/vscode.nvim',
  lazy = true,
  enabled = false,
  priority = 1000,
  -- opts = {
  --   -- Alternatively set style in setup
  --   style = 'light',
  --
  --   -- Enable transparent background
  --   -- transparent = true,
  --
  --   -- Enable italic comment
  --   italic_comments = false,
  --
  --   -- Disable nvim-tree background color
  --   disable_nvimtree_bg = true,
  --
  --   -- Override colors (see ./lua/vscode/colors.lua)
  --   color_overrides = {
  --     vscLightBlue = '#000000',
  --     vscPopupBack = '#DDDDDD',
  --     vscLineNumber = '#000000',
  --     vscSelection = '#000000',
  --     vscCursorLight = '#0000AA',
  --   },
  --
  --   -- Override highlight groups (see ./lua/vscode/theme.lua)
  --   group_overrides = {
  --       Visual = { fg='#ffffff', bg='#000000' },
  --       -- this supports the same val table as vim.api.nvim_set_hl
  --       -- use colors from this colorscheme by requiring vscode.colors!
  --       -- Cursor = { fg=c.vscCursorLight, bg='#FFFFFF', bold=true },
  --       -- Cursor = { fg='#0000AA', bg='#FFFFFF', bold=true },
  --   }
  -- },
  -- config = function()
  --   -- require('vscode').load()
  --   -- vim.opt.background = 'light'
  --   -- vim.cmd.colorscheme 'vscode'
  -- end,
}
