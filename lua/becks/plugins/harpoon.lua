return {
  'ThePrimeagen/harpoon',
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  enabled = true,
  lazy = true,
  -- event = "BufEnter",
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = 'Harpoon add file' })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon toggle menu' })

    vim.keymap.set("n", "<C-g>", function() harpoon:list():select(1) end, { desc = 'Harpoon jump 1' })
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = 'Harpoon jump 2' })
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = 'Harpoon jump 3' })
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = 'Harpoon jump 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = 'Harpoon jump prev' })
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = 'Harpoon jump next' })
  end
}
