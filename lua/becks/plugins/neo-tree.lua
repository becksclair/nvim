return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  opts = {
    enable_git_status = false,
    enable_diagnostics = false,
    close_if_last_window = false,
    popup_border_style = "rounded",
    -- Enable normal mode for input dialogs.
    enable_normal_mode_for_inputs = false,
    -- when opening files, do not use windows containing these filetypes or buftypes
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    -- used when sorting files and directories in the tree
    sort_case_insensitive = false,
    filesystem = {
      hijack_netrw_behavior = "open_current",
    },
    window = {
      position = "right"
    }
  }
}
