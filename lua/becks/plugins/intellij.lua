return {
  'chiendo97/intellij.vim',
  lazy = true,
  enabled = false,
  priority = 1000,
  config = function()
    vim.cmd('set background=light')
    vim.cmd('colorscheme intellij')
  end
}
