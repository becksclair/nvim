return {
  "felipeagc/fleet-theme-nvim",
  lazy = true,
  enabled = false,
  priority = 1000,
  config = function()
    vim.cmd('set background=dark')
    vim.cmd('colorscheme fleet')
  end
}
