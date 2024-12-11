return {
  "folke/snacks.nvim",
  priority = 1000,
  enabled = true,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    dashboard = {
      enabled = true,
      width = 100,
      row = nil,                                                                   -- dashboard position. nil for center
      col = nil,                                                                   -- dashboard position. nil for center
      pane_gap = 4,                                                                -- empty columns between vertical panes
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = function(cmd, opts)
          local builtin = require('telescope.builtin')
          if cmd == 'files' then
            builtin.find_files(opts)
          elseif cmd == 'oldfiles' then
            builtin.oldfiles(opts)
          elseif cmd == 'live_grep' then
            builtin.live_grep(opts)
          else
            print('Unknown command:', cmd)
          end
        end,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":Telescope git_files" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          -- { icon = " ", title = "Projects", section = "projects"  },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = "󰁯 ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Used by the `header` section
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      -- item field formatters
      formats = {
        icon = function(item)
          if item.file and item.icon == "file" or item.icon == "directory" then
            return M.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      sections = {
        { section = "header", width = 30 },
        { section = "keys",   gap = 1,   padding = 1, width = 30 },
        -- { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
        {
          pane = 2,
          icon = " ",
          desc = "Browse Repo",
          padding = 1,
          key = "b",
          action = function()
            Snacks.gitbrowse()
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            -- {
            --   title = "Notifications",
            --   cmd = "gh status -o UgcToday",
            --   action = function()
            --     vim.ui.open("https://github.com/notifications")
            --   end,
            --   key = "n",
            --   icon = " ",
            --   height = 5,
            --   width = 100,
            --   enabled = true,
            -- },
            -- {
            --   title = "Open Issues",
            --   cmd = "gh issue list -L 3",
            --   key = "i",
            --   action = function()
            --     vim.fn.jobstart("gh issue list --web", { detach = true })
            --   end,
            --   icon = " ",
            --   height = 7,
            -- },
            -- {
            --   icon = " ",
            --   title = "Open PRs",
            --   cmd = "gh pr list -L 3",
            --   key = "p",
            --   action = function()
            --     vim.fn.jobstart("gh pr list --web", { detach = true })
            --   end,
            --   height = 7,
            --   width = 100,
            -- },
            {
              icon = " ",
              title = "Git Status",
              cmd = "hub --no-pager diff --stat -B -M -C",
              height = 10,
              width = 100,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              width = 100,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        { section = "startup" },
      }
    },
    bigfile = {
      enabled = true
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    -- statuscolumn = {
    --   enabled = false,
    --   left = { "mark", "sign" }, -- priority of signs on the left (high to low)
    --   right = { "fold", "git" }, -- priority of signs on the right (high to low)
    --   folds = {
    --     open = false,            -- show open fold icons
    --     git_hl = false,          -- use Git Signs hl for fold icons
    --   },
    --   -- git = {
    --   --   -- patterns to match Git signs
    --   --   patterns = { "GitSign", "MiniDiffSign" },
    --   -- },
    --   refresh = 50, -- refresh at most every 50ms
    -- },
    ---@class snacks.dim.Config
    -- dim = {
    --   enabled = true,
    -- },
    ---@class snacks.input.Config
    input = {
      -- your input configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      icon = " ",
      icon_hl = "SnacksInputIcon",
      win = { style = "input" },
      expand = true,
    },
    toggle = {
      map = vim.keymap.set, -- keymap.set function to use
      which_key = true,     -- integrate with which-key to show enabled/disabled icons and colors
      notify = true,        -- show a notification when toggling
      -- icons for enabled/disabled states
      icon = {
        enabled = " ",
        disabled = " ",
      },
      -- colors for enabled/disabled states
      color = {
        enabled = "green",
        disabled = "yellow",
      },
    },
    ---@class snacks.words.Config
    ---@field enabled? boolean
    words = {
      enabled = true,
      debounce = 200, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { "n", "i", "c" }, -- modes to show references
    },
    styles = {
      notification = {
        wo = {
          winblend = 20,
          wrap = true
        } -- Wrap notifications
      }
    }
  },
  keys = {
    { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
    { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
    { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
    { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
    { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
    { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
    { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
    { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
    { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
    -- { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          relative = 'editor',
          width = 0.6,
          height = 0.6,
          wo = {
            winblend = 20,
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })
  end,
}
