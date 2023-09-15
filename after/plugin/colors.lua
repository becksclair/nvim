if not vim.g.neovide then
  require('rose-pine').setup({
    disable_background = true
  })
end
require('tokyonight').setup({
  transparent = true
})

function ColorMyPencils(color)
  color = color or "rose-pine"
  -- color = color or "iceberg"
  -- color = color or "tokyonight-night"
  vim.cmd.colorscheme(color)


  if not vim.g.neovide then
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
end

ColorMyPencils()
