-- Show context of the current function
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  enabled = true,
  cond = not require('becks.misc').RunningOnVConsole(),
  opts = function()
    local tsc = require("treesitter-context")
    local Snacks = require("snacks")

    Snacks.toggle({
      name = "Treesitter Context",
      get = tsc.enabled,
      set = function(state)
        if state then
          tsc.enable()
        else
          tsc.disable()
        end
      end,
    }):map("<leader>ut")

    return {
      mode = "cursor",
      max_lines = 3
    }
  end,
}
