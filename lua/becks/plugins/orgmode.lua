return {
  'nvim-orgmode/orgmode',
  lazy = true,
  enabled = false,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
  },
  event = 'VeryLazy',
  config = function()
    -- Load treesitter grammar for org
    require('orgmode').setup_ts_grammar()

    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/personal/notes/**/*',
      org_default_notes_file = '~/personal/notes/pages/inbox.org',
    })
  end
}
