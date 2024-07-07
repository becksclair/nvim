return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  enabled = true,
  lazy = true,
  event = "BufReadPost",
  opts = {
    -- See `:help gitsigns.txt`
    -- signs = {
    --   add = { text = '+' },
    --   change = { text = '~' },
    --   delete = { text = '_' },
    --   topdelete = { text = '‾' },
    --   changedelete = { text = '~' },
    -- },
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    current_line_blame = false,
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

      vim.cmd [[
        :highlight GitGutterAdd guibg=#1e2132 ctermbg=235
        :highlight GitGutterChange guibg=#1e2132 ctermbg=235
        :highlight GitGutterChangeDelete guibg=#1e2132 ctermbg=235
        :highlight GitGutterDelete guibg=#1e2132 ctermbg=235
        " :highlight SignColumn guibg=#1e2132 ctermbg=235
        :highlight SignColumn guibg=none ctermbg=235
        :highlight GitSignsAdd guibg=NONE ctermbg=235
        :highlight GitSignsChange guibg=NONE ctermbg=235
        :highlight GitSignsDelete guibg=NONE ctermbg=235
      ]]

      -- don't override the built-in and fugitive keymaps
      local gs = package.loaded.gitsigns
      vim.keymap.set({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
      vim.keymap.set({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
    end,
  },
}
