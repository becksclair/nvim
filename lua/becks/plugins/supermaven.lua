return {
  "supermaven-inc/supermaven-nvim",
  enabled = true,
  lazy = true,
  event = "BufReadPost",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
      },
      ignore_filetypes = {
        env = false,
      },
    })
  end,
}
