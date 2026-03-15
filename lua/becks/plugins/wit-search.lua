return {
  "aliqyan-21/wit.nvim",
  event = "VeryLazy",
  opts = {
    -- You can choose your preferred search engine from
    -- the supported list: {google, bing, duckduckgo, ecosia, brave, perplexity}.
    --
    -- There's also the possibility of just specifying a custom
    -- search engine URL by providing the base URL and the required search params.
    -- EXAMPLE:
    -- engine = "https://<your_preferred_search_engine>/search?q="
    engine = "google",                       -- search engine (default: "google")

    command_search = "WitSearch",            -- custom command to search (default: "WitSearch")
    command_search_visual = "WitSearchVisual", -- custom command to search visually (default: "WitSearchVisual")
    command_search_wiki = "WitSearchWiki",   -- custom command to search wikipedia (default: "WitSearchWiki")
  },
  config = function(_, opts)
    require('wit').setup(opts)

    vim.keymap.set('n', '<Leader>s0', ':WitSearch<CR>', { desc = 'Search with Wit' })
    vim.keymap.set('v', '<Leader>s0', ':WitSearchVisual<CR>', { desc = 'Search with Wit' })
  end
}
