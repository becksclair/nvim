return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = true,
  cond = not require('becks.misc').RunningOnVConsole(),
  version = false, -- set this if you want to always pull the latest change

  -- If you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- build = "make BUILD_FROM_SOURCE=true",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows

  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    -- "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
    'saghen/blink.cmp',
    -- "echasnovski/mini.icons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },

    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'echasnovski/mini.icons'
      }, -- if you prefer nvim-web-devicons

      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        file_types = { "markdown", "Avante", "vimwiki" },
        only_render_image_at_cursor = false,
      },
      ft = { "markdown", "Avante", "vimwiki", "norg", "rmd", "org" },
      cmd = { 'RenderMarkdown' },
      config = function(_, opts)
        require("render-markdown").setup(opts)

        Snacks.toggle({
          name = "Render Markdown",
          get = function()
            return require("render-markdown.state").enabled
          end,
          set = function(enabled)
            local m = require("render-markdown")
            if enabled then
              m.enable()
            else
              m.disable()
            end
          end,
        }):map("<leader>um")

        vim.treesitter.language.register('markdown', 'vimwiki')
      end,
    },
  },

  opts = {
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    provider = "claude", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
    ---@alias Mode "agentic" | "legacy"
    mode = "agentic", -- The default mode for interaction. "agentic" uses tools to automatically generate code, "legacy" uses the old planning method to generate code.

    auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot

    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-7-sonnet-20250219",
      -- temperature = 0,
      -- max_tokens = 4096,
      -- max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      -- reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },

    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4.1-2025-04-14",
      timeout = 30000, -- Timeout in milliseconds
      -- temperature = 0,
      -- max_tokens = 4096,
      -- max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      -- reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },

    ---Specify the special dual_boost mode
    ---1. enabled: Whether to enable dual_boost mode. Default to false.
    ---2. first_provider: The first provider to generate response. Default to "openai".
    ---3. second_provider: The second provider to generate response. Default to "claude".
    ---4. prompt: The prompt to generate response based on the two reference outputs.
    ---5. timeout: Timeout in milliseconds. Default to 60000.

    ---How it works:
    --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.

    ---Note: This is an experimental feature and may not work as expected.
    dual_boost = {
      enabled = false,
      first_provider = "openai",
      second_provider = "claude",
      prompt =
      "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
      timeout = 60000, -- Timeout in milliseconds
    },

    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
    },

    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },

    hints = { enabled = true },

    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true,        -- similar to vim.o.wrap
      width = 30,         -- default % based on available width
      sidebar_header = {
        enabled = true,   -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
    },

    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },

    --- @class AvanteConflictUserConfig
    diff = {
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
      --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
      --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
      --- Disable by setting to -1.
      override_timeoutlen = 500,
    },
  },
}
