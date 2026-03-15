return {
  "vuki656/package-info.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim"
  },
  lazy = true,
  enabled = false,
  event = "BufReadPost",
  opts = {
    package_manager = 'pnpm'
  },
  config = function()
    require("telescope").load_extension("package_info")

    -- Show dependency versions
    vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true, desc = 'Package Info' })

    -- Hide dependency versions
    vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true, desc = 'Hide Package Info' })

    -- Toggle dependency versions
    vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { silent = true, noremap = true, desc = 'Toggle dependency versions' })

    -- Update dependency on the line
    vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update, { silent = true, noremap = true, desc = 'Update line dependency' })

    -- Delete dependency on the line
    vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete, { silent = true, noremap = true, desc = 'Delete line dependency' })

    -- Install a new dependency
    vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install, { silent = true, noremap = true, desc = 'Install new dependency' })

    -- Install a different dependency version
    vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version, { silent = true, noremap = true, desc = 'Install a different dependency version' })
  end
}
