-- Undo GUI
return {
  'mbbill/undotree',
  enabled = false,
  lazy = true,
  event = "VeryLazy",
  cmd = {
    "UndotreeToggle"
  },
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle", desc = "Open undo tree" }
  }
}
