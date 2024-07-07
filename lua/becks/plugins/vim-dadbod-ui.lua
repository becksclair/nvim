-- Database
return {
  'kristijanhusak/vim-dadbod-ui',
  lazy = true,
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = {
        -- 'sql',
        -- 'mysql',
        'plsql'
      },
      lazy = true
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_win_position = 'right'
    vim.g.db_ui_minwidth = 60
  end,
}
