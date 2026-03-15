return {
  "yetone/avante.nvim",
  enabled = false,
  event = "VeryLazy",
  lazy = true,
  cond = not require('becks.misc').RunningOnVConsole(),
  version = false, -- set this if you want to always pull the latest change

  -- If you want to build from source then do `BUILD_FROM_SOURCE=true make`
  build = function()
    if vim.fn.has("win32") == 1 then
      return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    else
      return "BUILD_FROM_SOURCE=true make"
    end
  end,

  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    -- "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
    'saghen/blink.cmp',
    "echasnovski/mini.icons", -- or echasnovski/mini.icons
    "echasnovski/mini.pick",  -- for file_selector provider mini.pick
    -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "folke/snacks.nvim",      -- for input provider snacks
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

  ---@module 'avante'
  ---@type avante.Config
  opts = {
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    ---@type Provider
    provider = "openai", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
    ---@alias Mode "agentic" | "legacy"
    ---@type Mode
    mode = "agentic", -- The default mode for interaction. "agentic" uses tools to automatically generate code, "legacy" uses the old planning method to generate code.

    instructions_file = "~/personal/AGENTS.md",

    -- auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot

    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        -- model = "claude-opus-4-1-20250805",
        -- model = "claude-opus-4-20250514",
        model = "claude-sonnet-4-20250514",
        timeout = 60000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
          -- max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          -- reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
      },

      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-5-mini",
        timeout = 60000, -- Timeout in milliseconds, increase this for reasoning models
        extra_request_body = {
          temperature = 1,
          -- max_tokens = 20480,
          max_completion_tokens = 4096, -- Increase this to include reasoning tokens (for reasoning models)
        },
      },

      moonshot = {
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2-0711-preview",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 32768,
        },
      },
    },

    acp_providers = {
      ["gemini-cli"] = {
        command = "gemini",
        args = { "--experimental-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
        },
      },
      ["claude-code"] = {
        command = "npx",
        args = { "@zed-industries/claude-code-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          -- ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
    },

    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, google, kagi, brave, or searxng
      proxy = nil,         -- proxy support, e.g., http://127.0.0.1:7890
    },

    override_prompt_dir = vim.fn.expand("~/.claude/commands"),

    custom_tools = {
      {
        name = "run_go_tests",                                -- Unique name for the tool
        description = "Run Go unit tests and return results", -- Description shown to AI
        command = "go test -v ./...",                         -- Shell command to execute
        param = {                                             -- Input parameters (optional)
          type = "table",
          fields = {
            {
              name = "target",
              description = "Package or directory to test (e.g. './pkg/...' or './internal/pkg')",
              type = "string",
              optional = true,
            },
          },
        },
        returns = { -- Expected return values
          {
            name = "result",
            description = "Result of the fetch",
            type = "string",
          },
          {
            name = "error",
            description = "Error message if the fetch was not successful",
            type = "string",
            optional = true,
          },
        },
        func = function(params, on_log, on_complete) -- Custom function to execute
          local target = params.target or "./..."
          return vim.fn.system(string.format("go test -v %s", target))
        end,
      },
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
      first_provider = "claude",
      second_provider = "openai",
      prompt =
      "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
      timeout = 60000, -- Timeout in milliseconds
    },

    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,                 -- Whether to remove unchanged lines when applying a code block
      enable_token_counting = true,         -- Whether to enable token counting. Default to true.
      auto_approve_tool_permissions = true, -- Default: show permission prompts for all tools
      -- Examples:
      -- auto_approve_tool_permissions = true,                -- Auto-approve all tools (no prompts)
      -- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- Auto-approve specific tools only
    },

    prompt_logger = {                                         -- logs prompts to disk (timestamped, for replay/debugging)
      enabled = true,                                         -- toggle logging entirely
      log_dir = vim.fn.stdpath("cache") .. "/avante_prompts", -- directory where logs are saved
      fortune_cookie_on_success = false,                      -- shows a random fortune after each logged prompt (requires `fortune` installed)
      next_prompt = {
        normal = "<C-n>",                                     -- load the next (newer) prompt log in normal mode
        insert = "<C-n>",
      },
      prev_prompt = {
        normal = "<C-p>", -- load the previous (older) prompt log in normal mode
        insert = "<C-p>",
      },
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
      cancel = {
        normal = { "<C-c>", "<Esc>", "q" },
        insert = { "<C-c>" },
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        retry_user_request = "r",
        edit_user_request = "e",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        remove_file = "d",
        add_file = "@",
        close = { "<Esc>", "q" },
        close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
      },
    },

    selection = {
      enabled = true,
      hint_display = "delayed",
    },

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
      ---@type AvanteConflictHighlights
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
    suggestion = {
      debounce = 600,
      throttle = 600,
    },
  },
}
