return {
  'xiyaowong/transparent.nvim',
  enabled = true,
  lazy = false,
  opts = {
    groups = {   -- table: default groups
      'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
      'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
      'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
      'SignColumn', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
      'EndOfBuffer',
      -- 'CursorLine',
    },
    extra_groups = {},     -- table: additional groups that should be cleared
    exclude_groups = {},   -- table: groups you don't want to clear
  }
}
