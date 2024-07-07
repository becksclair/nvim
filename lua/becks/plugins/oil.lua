return {
  'stevearc/oil.nvim',
  event = "VeryLazy",

  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,

      columns = {
        "icon",
        -- "size",
        -- "mtime",
      },
      keymaps = {
        -- ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
        natural_order = false,

        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name)
          return vim.startswith(name, ".") or name == ".git"
        end,
      },
      win_options = {
        wrap = true,
      },

      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 200,
        max_height = 50,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
    }

    -- Open parent directory in current window
    vim.keymap.set("n", "<space>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    -- Open parent directory in floating window
    vim.keymap.set("n", "-", require("oil").toggle_float, { desc = "Open parent directory in floating window" })
  end
}
