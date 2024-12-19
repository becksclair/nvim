return {
  "sphamba/smear-cursor.nvim",
  enabled = false,
  event = "VeryLazy",
  cond = vim.g.neovide == nil and vim.env.KITTY_WINDOW_ID == nil and (not require('becks.misc').RunningOnVConsole()),
  opts = {
    cursor_color = "#cdd6f4",
    smear_between_neighbor_lines = true,
    legacy_computing_symbols_support = true,

    stiffness = 0.8,               -- 0.6      [0, 1]
    trailing_stiffness = 0.5,      -- 0.3      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0
    hide_target_hack = false,      -- true     boolean
  },
}
