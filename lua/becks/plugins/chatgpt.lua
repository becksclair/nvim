return {
  "jackMort/ChatGPT.nvim",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  cmd = {
    "ChatGPT",
    "ChatGPTRun"
  },
  keys = {
    -- { "<F8>", "<cmd>ChatGPT<cr>", desc = "Open ChatGPT" },
  },
  opts = {
    api_key_cmd = nil,
    yank_register = "+",
    edit_with_instructions = {
      diff = false,
      keymaps = {
        close = "<C-c>",
        accept = "<C-y>",
        toggle_diff = "<C-d>",
        toggle_settings = "<C-o>",
        cycle_windows = "<Tab>",
        use_output_as_input = "<C-i>",
      },
    },
    chat = {
      welcome_message = WELCOME_MESSAGE,
      loading_text = "Loading, please wait ...",
      question_sign = "",
      answer_sign = "ﮧ",
      max_line_length = 120,
      sessions_window = {
        border = {
          style = "rounded",
          text = {
            top = " Sessions ",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      },
      keymaps = {
        close = { "<C-c>" },
        yank_last = "<C-y>",
        yank_last_code = "<C-k>",
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        new_session = "<C-n>",
        cycle_windows = "<Tab>",
        cycle_modes = "<C-f>",
        select_session = "<Space>",
        rename_session = "r",
        delete_session = "d",
        draft_message = "<C-d>",
        toggle_settings = "<C-o>",
        toggle_message_role = "<C-r>",
        toggle_system_role_open = "<C-s>",
        stop_generating = "<C-x>",
      },
    },
    popup_layout = {
      default = "center",
      center = {
        width = "80%",
        height = "80%",
      },
      right = {
        width = "30%",
        width_settings_open = "50%",
      },
    },
    popup_window = {
      border = {
        highlight = "FloatBorder",
        style = "rounded",
        text = {
          top = " ChatGPT ",
        },
      },
      win_options = {
        wrap = true,
        linebreak = true,
        foldcolumn = "1",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
      buf_options = {
        filetype = "markdown",
      },
    },
    system_window = {
      border = {
        highlight = "FloatBorder",
        style = "rounded",
        text = {
          top = " SYSTEM ",
        },
      },
      win_options = {
        wrap = true,
        linebreak = true,
        foldcolumn = "2",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
    popup_input = {
      prompt = "  ",
      border = {
        highlight = "FloatBorder",
        style = "rounded",
        text = {
          top_align = "center",
          top = " Prompt ",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
      submit = "<C-Enter>",
      submit_n = "<Enter>",
      max_visible_lines = 20
    },
    settings_window = {
      border = {
        style = "rounded",
        text = {
          top = " Settings ",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
    openai_params = {
      model = "gpt-4o",
      frequency_penalty = 0.1,
      presence_penalty = 0.1,
      max_tokens = 1024,
      temperature = 0.1,
      top_p = 0.9,
      n = 2,
    },
    openai_edit_params = {
      model = "gpt-4o",
      temperature = 0.1,
      top_p = 0.9,
      n = 1,
    },
    actions_paths = {},
    show_quickfixes_cmd = "Trouble quickfix",
    predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
  },
  init = function()

  end,
  config = function(_, opts)
    require("chatgpt").setup(opts)
    local chatgpt = require("chatgpt")

    -- vim.keymap.set('n', '<F8>', require("chatgpt").openChat, { noremap = true, silent = true, desc = 'Open ChatGPT' })
    -- vim.keymap.set('n', '<F5>', require("chatgpt").edit_with_instructions, { noremap = true, silent = false, desc = 'Edit ChatGPT' })
    -- vim.keymap.set('v', '<F5>', require("chatgpt").edit_with_instructions, { noremap = true, silent = false, desc = 'Edit ChatGPT' })


    vim.keymap.set('n', '<S-F5>', chatgpt.edit_with_instructions, { noremap = true, silent = false, desc = 'Edit ChatGPT' })
    vim.keymap.set('v', '<S-F5>', chatgpt.edit_with_instructions, { noremap = true, silent = false, desc = 'Edit ChatGPT' })



    -- vim.keymap.set({ 'n', 'v' }, '<Leader>cc', require("chatgpt").complete_code,
      -- { noremap = true, silent = false, desc = 'Complete with ChatGPT' })
    -- vim.keymap.set('v', '<Leader>c', chatgpt.complete_code, { noremap = true, silent = true, desc = 'Complete with ChatGPT' })

    vim.keymap.set({ 'n' }, '<Leader>ce', '<cmd>ChatGPTRun explain_code<CR>',
      { noremap = true, silent = false, desc = 'Explain with ChatGPT' })
    vim.keymap.set('v', '<Leader>ce', '<cmd>ChatGPTRun explain_code<CR>',
      { noremap = true, silent = false, desc = 'Explain with ChatGPT' })

    vim.keymap.set({ 'n', 'v' }, '<Leader>co', '<cmd>ChatGPTRun optimize_code<CR>',
      { noremap = true, silent = false, desc = 'Optimize with ChatGPT' })
    vim.keymap.set({ 'v' }, '<Leader>co', '<cmd>ChatGPTRun optimize_code<CR>',
      { noremap = true, silent = false, desc = 'Optimize with ChatGPT' })

    vim.keymap.set({ 'n', 'v' }, '<Leader>cb', '<cmd>ChatGPTRun fix_bugs<CR>',
      { noremap = true, silent = false, desc = 'Fix bugs with ChatGPT' })
    vim.keymap.set('v', '<Leader>cb', '<cmd>ChatGPTRun fix_bugs<CR>',
      { noremap = true, silent = false, desc = 'Fix bugs with ChatGPT' })

    vim.keymap.set({ 'n', 'v' }, '<Leader>cr', '<cmd>ChatGPTRun code_readability_analysis<CR>',
      { noremap = true, silent = false, desc = 'Readability Analysis with ChatGPT' })
    vim.keymap.set('v', '<Leader>cr', '<cmd>ChatGPTRun code_readability_analysis<CR>',
      { noremap = true, silent = false, desc = 'Readability Analysis with ChatGPT' })
  end,
}
