return {
  'ThePrimeagen/git-worktree.nvim',
  lazy = true,
  opts = {
    -- change_directory_command = <str> -- default: "cd",
    -- update_on_change = <boolean> -- default: true,
    -- update_on_change_command = <str> -- default: "e .",
    -- clearjumps_on_change = <boolean> -- default: true,
    -- autopush = <boolean> -- default: false,
  },
  config = function()
    require("telescope").load_extension("git_worktree")

    local Worktree = require("git-worktree")

    -- op = Operations.Switch, Operations.Create, Operations.Delete
    -- metadata = table of useful values (structure dependent on op)
    --      Switch
    --          path = path you switched to
    --          prev_path = previous worktree path
    --      Create
    --          path = path where worktree created
    --          branch = branch name
    --          upstream = upstream remote name
    --      Delete
    --          path = path where worktree deleted

    Worktree.on_tree_change(function(op, metadata)
      if op == Worktree.Operations.Switch then
        print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
        -- vim.cmd("cd " .. metadata.path)
        -- setlocal bufhidde=hide
        -- vim.cmd('SessionRestore')             -- Restore the directory session when switching
        -- TODO: Check what type of project this is and install deps when switching
        -- vim.cmd("TermExec open=0 cmd='pnpm i --verbose'")
      end
    end)
  end

}
