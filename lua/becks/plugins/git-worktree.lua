return {
  'ThePrimeagen/git-worktree.nvim',
  lazy = true,
  event = "VeryLazy",
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

    -- Creates a worktree.  Requires the path, branch name, and the upstream
    -- Example:
    -- :lua require("git-worktree").create_worktree("feat-69", "master", "origin")

    -- switches to an existing worktree.  Requires the path name
    -- Example:
    -- :lua require("git-worktree").switch_worktree("feat-69")

    -- deletes to an existing worktree.  Requires the path name
    -- Example:
    -- :lua require("git-worktree").delete_worktree("feat-69")

    function Gwadd(opts)
      local branch = opts.fargs[1] or vim.fn.input("Branch name: ")
      local git_branch = "feat-" .. branch
      require("git-worktree").create_worktree(git_branch, "main", "origin")
    end

    vim.api.nvim_create_user_command('Gwadd', Gwadd, { nargs = 1 })

    function Gwsw(opts)
      local branch = opts.fargs[1] or vim.fn.input("Branch name: ")
      local git_branch = "feat-" .. branch
      require("git-worktree").switch_worktree(git_branch)
    end

    vim.api.nvim_create_user_command('Gwsw', Gwsw, { nargs = 1 })

    function Gwrm()
      local branch = vim.fn.input("Branch name: ")
      local git_branch = "feat-" .. branch
      require("git-worktree").delete_worktree(git_branch, true)
    end

    vim.api.nvim_create_user_command('Gwrm', Gwsw, {})

    vim.keymap.set("n", "<leader>ts", require('telescope').extensions.git_worktree.git_worktrees,
      { desc = 'Switch worktree' })
    vim.keymap.set("n", "<leader>ta", require('telescope').extensions.git_worktree.create_git_worktree,
      { desc = 'Add worktree' })
    -- vim.keymap.set("n", "<leader>wr", "<cmd>lua Gwrm()")
    vim.keymap.set("n", "<leader>tr", Gwrm, { desc = 'Remove worktree' })
  end

}
