return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  event = "VeryLazy",
  enabled = false,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  config = function()
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup({

      enable_git_status = true,
      enable_diagnostics = true,
      close_if_last_window = true,
      popup_border_style = "rounded",
      -- Enable normal mode for input dialogs.
      -- enable_normal_mode_for_inputs = false,
      -- neo_tree_popup_input_ready = false,
      -- when opening files, do not use windows containing these filetypes or buftypes
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      -- used when sorting files and directories in the tree
      sort_case_insensitive = false,
      window = {
        position = "right",
        width = 79,
        mappings = {
          ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        },
      },

      default_component_configs = {
        container = {
          enable_character_fade = true
        },
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "✖", -- this can only be used in the git_status source
            renamed   = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          }
        },
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
          enabled = true,
          required_width = 64, -- min width of window required to show this column
        },

        type = {
          enabled = true,
          required_width = 122, -- min width of window required to show this column
        },
        last_modified = {
          enabled = true,
          required_width = 79, -- min width of window required to show this column
        },
        symlink_target = {
          enabled = false,
        },
      },

      filesystem = {
        hijack_netrw_behavior = "open_current",
        follow_current_file = {
          enabled = true,               -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false,      -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = true,        -- when true, empty folders will be grouped together
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        --  instead of relying on nvim autocmd events.
        filtered_items = {
          visible = true,         -- Set to true to display hidden items differently
          hide_dotfiles = false,  -- Hide dotfiles (files starting with a dot)
          hide_gitignored = true, -- Hide files ignored by Git
          hide_hidden = true,     -- Only for Windows hidden files
          hide_by_name = {
            "node_modules",       -- Add any directory names you want to hide
            ".cache",
            ".git",
          },
          always_show = { -- Specify items to always show, even if they match hidden patterns
            ".gitignore",
            ".github",
          },
          never_show = { -- Specify items to never show, even if visible is set to true
            ".DS_Store",
            "thumbs.db",
          },
       },
      },
    })
  end,
}
