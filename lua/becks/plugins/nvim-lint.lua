return {
  'mfussenegger/nvim-lint',
  lazy = true,
  event = "BufReadPost",
  opts = {
    linters = {
      shellcheck = {
        args = {
          '-s',
          'bash',
          '--format',
          'json1',
          '-'
        }
      },
      nu_check = {
        cmd = 'nu',
        stdin = false,
        append_fname = false,
        ignore_exitcode = true,
        args = {
          '--ide-check',
          '1000',
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
        parser = function(output, bufnr)
          if output == '' then
            return {}
          end

          for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
            if client.name == 'nushell' then
              return {}
            end
          end

          local severity_map = {
            Error = vim.diagnostic.severity.ERROR,
            Warning = vim.diagnostic.severity.WARN,
            Info = vim.diagnostic.severity.INFO,
            Hint = vim.diagnostic.severity.HINT,
          }

          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          local line_starts = {}
          local offset = 0

          for index, line in ipairs(lines) do
            line_starts[index] = offset
            offset = offset + #line + 1
          end

          local function offset_to_position(byte_offset)
            local target = math.max(tonumber(byte_offset) or 0, 0)

            for index = #line_starts, 1, -1 do
              if target >= line_starts[index] then
                return index - 1, math.max(target - line_starts[index], 0)
              end
            end

            return 0, 0
          end

          local diagnostics = {}
          for _, line in ipairs(vim.split(output, '\n', { trimempty = true })) do
            local ok, item = pcall(vim.json.decode, line)
            if ok and item and item.type == 'diagnostic' then
              local lnum, col = offset_to_position(item.span and item.span.start)
              local end_lnum, end_col = offset_to_position(item.span and item.span['end'])

              if end_lnum == lnum and end_col == col then
                end_col = col + 1
              end

              table.insert(diagnostics, {
                lnum = lnum,
                col = col,
                end_lnum = end_lnum,
                end_col = end_col,
                severity = severity_map[item.severity] or vim.diagnostic.severity.ERROR,
                source = 'nu',
                message = item.message,
              })
            end
          end

          return diagnostics
        end,
      }
    },

    linters_by_ft = {
      markdown = { "markdownlint-cli", "vale" },

      -- python = { 'flake8', 'pylint', },
      python = { 'ruff' },
      sql = { 'sqlfluff', },

      bash = { 'shellcheck', },
      shell = { 'shellcheck', },
      zsh = { 'shellcheck', },
      nu = { 'nu_check', },
      cpp = { 'clangtidy' },

      -- yaml = { 'cfn_lint' },

      -- vlang = { 'vlang' },

      -- rust = { 'clippy' }
    }
  },

  config = function(_, opts)
    local lint = require("lint")

    local function should_skip_lint(bufnr)
      if vim.bo[bufnr].filetype ~= "nu" then
        return false
      end

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client.name == "nushell" then
          return true
        end
      end

      return false
    end

    local function try_lint()
      local bufnr = vim.api.nvim_get_current_buf()
      if should_skip_lint(bufnr) then
        return
      end

      lint.try_lint()
    end

    for name, linter in pairs(opts.linters or {}) do
      local existing = lint.linters[name]
      if existing then
        lint.linters[name] = vim.tbl_deep_extend("force", existing, linter)
      else
        lint.linters[name] = linter
      end
    end

    for filetype, linters in pairs(opts.linters_by_ft or {}) do
      lint.linters_by_ft[filetype] = linters
    end

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>bl", try_lint, { desc = "Lint file" })

    vim.api.nvim_create_user_command("NuCheck", function()
      if vim.bo.filetype ~= "nu" then
        vim.notify("NuCheck is for Nushell buffers", vim.log.levels.WARN)
        return
      end

      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      local has_nushell_lsp = false

      for _, client in ipairs(clients) do
        if client.name == "nushell" then
          has_nushell_lsp = true
          break
        end
      end

      if not has_nushell_lsp then
        try_lint()
      end

      local diagnostics = vim.diagnostic.get(bufnr)
      if #diagnostics == 0 then
        local source = has_nushell_lsp and "nushell LSP" or "nu-check"
        vim.notify("NuCheck: no diagnostics (" .. source .. ")", vim.log.levels.INFO)
        return
      end

      vim.diagnostic.open_float(bufnr, { scope = "buffer" })
    end, { desc = "Check current Nushell buffer" })

    vim.api.nvim_create_user_command("NuLint", function()
      if vim.bo.filetype ~= "nu" then
        vim.notify("NuLint is for Nushell buffers", vim.log.levels.WARN)
        return
      end

      try_lint()
      vim.diagnostic.open_float(0, { scope = "buffer" })
    end, { desc = "Run nu-check on current Nushell buffer" })
  end,
}
