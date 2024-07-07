-- Autopairs
return {
  "windwp/nvim-autopairs",
  lazy = true,
  event = "InsertEnter",
  enabled = true,
  config = true,
  dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
}
