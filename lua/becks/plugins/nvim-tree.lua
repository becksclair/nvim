local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', opts('Toggle Tree'))
  -- keys = {
  --   {"n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true }}
  -- }
  -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  keys = {

  },
  opts = {
    sort_by = "case_sensitive",
    hijack_cursor = true,
    disable_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
      highlight_git = false,
      -- highlight_diagnostics = true,
    },
    git = {
      enable = false,
      show_on_dirs = false,
      show_on_open_dirs = false,
      disable_for_dirs = {},
      timeout = 400,
      cygwin_support = false,
    },
    filters = {
      dotfiles = false,
    },
    hijack_directories = {
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      }
    },
    on_attach = my_on_attach,
  },
  config = function()
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
  end,
}
