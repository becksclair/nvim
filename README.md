# Neovim Config — Lazy.nvim, LSP, Telescope, Oil, Harpoon, Snacks

Personal, modular Neovim setup powered by Lazy.nvim with one-file-per-plugin. It aims for fast startup, sensible defaults, and a great UX for daily coding across JS/TS, Go, Rust, Lua, Zig, Odin, V, SQL, and Markdown.

## Highlights

- Lazy.nvim plugin manager with a file-per-plugin architecture (`lua/becks/plugins/*`)
- LSP out of the box via mason + lspconfig + neoconf; modern completion with blink.cmp + LuaSnip
- Telescope + fzf-native for fast find, with rich keymaps and custom symbol sources
- Oil.nvim as the file explorer (netrw disabled) and Harpoon v2 for ultra-fast file jumps
- Treesitter for highlighting, motions, textobjects, and incremental selection
- Formatting via conform.nvim, linting via nvim-lint, and sensible on-save tweaks
- Polished UI with noice.nvim + snacks.nvim (dashboard, notifications, terminal, toggles)
- Thoughtful defaults: system clipboard, helpful keymaps, easy theme switching, and per-language build keys

## Repository layout

- `init.lua` → `lua/becks/` main module
  - `becks/init.lua`: boot order: settings → keymaps → plugin manager → autocmds → neovide
  - `becks/lazy.lua`: Lazy.nvim bootstrap and setup (imports `becks.plugins`)
  - `becks/set.lua`: core options, OS detection, clipboard, filetype mappings
  - `becks/remap.lua`: global keymaps (leader = space, clipboard integration, motions, build keys)
  - `becks/autocmds.lua`: format-on-save for .templ, LSP/diagnostic tweaks
  - `after/plugin/colors.lua`: theme switching helpers and highlight adjustments
- `lua/becks/plugins/*`: one file per plugin (LSP, Telescope, Git, UI, etc.)
- `data/telescope-sources/*`: custom symbol sources for Telescope
- `ftplugin/*`: filetype-specific options
- `nlsp-settings/`: server-specific settings when needed

## Requirements

- Neovim 0.9+ (0.10 recommended)
- Git and a compiler toolchain (for telescope-fzf-native)
- Recommended CLI tools:
  - ripgrep, fd (faster search/backends for Telescope)
  - lazygit (optional, integrated via snacks.nvim)
  - Node.js (optional) for some formatters/linters if you prefer npm installs

On macOS (Homebrew):

```bash
brew install neovim ripgrep fd lazygit
# Ensure Xcode Command Line Tools are installed for builds
xcode-select --install || true
```

## Installation

1) Back up any existing config

    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak-$(date +%Y%m%d-%H%M%S)
    ```

2) Clone this repo as your Neovim config

    ```bash
    git clone https://github.com/becksclair/nvim ~/.config/nvim
    ```

3) Start Neovim. Lazy.nvim will bootstrap and install plugins

Optional follow-ups:

- Run :Lazy to review status and updates
- Run :Mason to install LSPs/formatters/linters (auto-install is enabled)
- Run :TSUpdate to fetch Treesitter parsers

### Mason tools: export, restore, and auto-install

This config includes portable helpers to manage your Mason tools across machines (macOS, Linux, Windows).

- Manual export of installed tools (writes one name per line):
  - `:MasonExport` → saves to `~/.config/nvim/mason-packages.txt` (uses Neovim's stdpath)

- Manual restore on a fresh machine:
  - `:MasonRestore` → refreshes the registry and queues installs from `mason-packages.txt`

- Automatic install on startup:
  - `mason-tool-installer` reads `mason-packages.txt` and installs missing tools automatically.
  - If the file doesn't exist yet, a small baseline (e.g. `lua-language-server`) is ensured so LSP works out of the box.

Tips

- Commit `mason-packages.txt` with your dotfiles to reuse the same toolset everywhere.
- You can still use `:Mason` for the UI, and `:MasonUpdate` to refresh indices.
- The export/restore logic uses only Neovim APIs and mason-registry; no shell assumptions (works on Windows too).

### External tools for format/lint

This config uses conform.nvim and nvim-lint. Many tools can be installed from Mason (preferred), or your package manager:

- Markdown: markdownlint-cli2, markdown-toc
- Web: biome or prettierd/prettier
- Shell: shellcheck
- SQL: sqlfluff

You can install via Mason UI (:Mason) or with Homebrew/npm as you prefer.

## Keymaps (cheat sheet)

Leader is space. Only a selection of the most-used maps is shown here.

### File explorer & buffers

- `-` open Oil.nvim floating directory view
- `<space>-` open Oil.nvim parent directory in-current window
- `<leader><space>` list buffers (Telescope)
- `<leader>xb` close current buffer

### Telescope

- `<leader>f` find files
- `<C-p>` Git files
- `<leader>ss` live grep
- `<leader>?` recent files
- `<leader>sk` keymaps picker
- `<leader>sy` symbols picker (uses built-in + custom sources in `data/telescope-sources/`)
- `<leader>sd` diagnostics
- `<leader>sa` Aerial symbols (outline)
- Git pickers: `<leader>sgs` status, `<leader>sgc` commits, `<leader>sgb` branches

### Harpoon v2

- `<leader>a` add file
- Jumps: `<C-g>`/`<C-t>`/`<C-n>`/`<C-s>` goto 1/2/3/4
- `<C-e>` open Harpoon list in Telescope
- `<C-S-P>`/`<C-S-N>` previous/next Harpoon item

### LSP (active when a server is attached)

- `K` hover
- `gd`/`gD` go to definition/declaration
- `gi` implementations, `go` type definition
- `gr` references, `gs` signature help
- `<F2>` rename, `<F3>` format, `<F4>` code action

### Formatting & linting

- `<F3>` Format buffer (conform.nvim)
- `<leader>bl` Run linters (nvim-lint)
- Web helpers: `<leader>bb` biome on current file, `<leader>bF` Prettier on current file
- SQL: `<C-S-f>` sqlfluff fix current file

### Diagnostics & quickfix

- `[d` / `]d` jump diagnostics with a float
- `<C-k>`/`<C-j>` quickfix next/prev; `<leader>k`/`<leader>j` location list next/prev

### Windows & movement

- `<C-h/j/k/l>` move across windows
- `<leader>v` split vertically, `<leader>q` close window
- Shift+Arrows resize
- `H`/`L` beginning/end of line; `jj` exits insert mode

### Clipboard

- `y`/`p` in normal/visual modes use the system clipboard by default

### Terminal, notifications, toggles (snacks.nvim)

- `<C-/>` toggle terminal
- `<leader>n` notification history, `<leader>un` dismiss all
- Toggles under `<leader>u`… (wrap, spell, numbers, diagnostics, treesitter, etc.)

### DB UI

- `<F10>` open DBUI (vim-dadbod-ui)

## Theming

Theme helpers live in `after/plugin/colors.lua`. The default theme is selected by `:SetTheme`, which checks `TERM_DARK_MODE` ("1"/"True" → dark, otherwise light) unless running in a bare console. Useful commands:

- `:SetTheme` — auto choose light/dark
- `:SetMelange` and `:SetMelangeDark` — preferred light/dark pair
- Other options exist: `:SetTokyoNight`, `:SetNightFox`, `:SetAcmeTheme`, `:SetTempusTempestTheme`, `:SetIntelliJTheme`, `:SetVsAssistTheme`, etc.

Custom highlights are applied for Visual/IncSearch, Telescope, and Copilot completion kinds.

## LSP, completion, syntax — rationale

- mason.nvim + mason-lspconfig + nvim-lspconfig
  - Auto-installs/manages LSP servers and tools; robust defaults with `neoconf.nvim`
  - Per-server overrides for lua_ls, jsonls (with schemastore), yamlls (CloudFormation/OpenAPI tags), bashls, etc.
- blink.cmp (instead of nvim-cmp)
  - Faster UX, inline docs/signature, friendly keymaps; LuaSnip and friendly-snippets included
- nvim-treesitter
  - Reliable highlighting, injections, incremental selection, textobjects; parsers installed/updated on-demand

## Files, search, navigation — rationale

- Telescope + fzf-native
  - Core finder with smooth UI, rich pickers, and smart layouts
  - Custom symbol sources in `data/telescope-sources/`
- Oil.nvim
  - Replaces netrw for a more ergonomic, buffer-based file explorer (floating or in-window)
- Harpoon v2
  - Lightning-fast file jumping with nice Telescope integration

## UI & quality of life — rationale

- noice.nvim
  - Modern command line, message routing, and cleaner LSP popups
- snacks.nvim
  - Dashboard, notifications, terminal, quickfile/bigfile, words navigation (`[[`/`]]`), and convenient toggles
- Other helpers
  - autopairs, comment, indent guides, dressing, lualine, etc. (see `lua/becks/plugins/`)

## Formatting & linting — rationale

- conform.nvim
  - Declarative per-filetype formatter routing (biome/prettier/prettierd, stylua, rustfmt, etc.)
- nvim-lint
  - On-write linting; markdownlint, ruff, sqlfluff, shellcheck, etc.
- Autocmd niceties
  - Format .templ with the external `templ` CLI on save when present
  - Disable diagnostics in `.env*` and `node_modules` to reduce noise

## Language-specific build keys

When editing files in these languages, build/run mappings attach automatically:

- V: `<F6>` run, `<S-F6>` prod build, `<F3>`/`<C-F3>` format
- Go: `<F6>` run, `<S-F6>` build, `<F3>`/`<C-F3>` format
- Zig: `<F6>` zig build run, `<S-F6>` build, `<F3>`/`<C-F3>` format/check
- Odin: `<F6>` run, `<S-F6>` build, `<F3>`/`<S-F3>` check
- Rust (Cargo): `<F6>` run, `<S-F6>` build, `<S-F3>` check

## Development notes

- Add plugins as individual files under `lua/becks/plugins/` following Lazy.nvim conventions
- Use `R("module.name")` during development to hot-reload Lua modules
- Theme switching helpers live in `after/plugin/colors.lua`
- Custom utilities in `lua/becks/misc.lua` (e.g., Mason export/restore commands, `SudoWrite` bound to `w!!` and `<Leader>WW`)

## Troubleshooting

- Telescope fzf-native failed to build
  - Ensure a compiler toolchain is installed (Xcode CLT on macOS), then `:Lazy build telescope-fzf-native.nvim`
- LSP servers don’t attach
  - Check `:Mason`, `:LspInfo`; install missing servers; verify project root
- Formatters don’t run
  - Check `:ConformInfo`; ensure the formatter binary is installed/visible in PATH or via Mason
- `templ` formatting does nothing
  - Install the `templ` CLI and ensure it’s on PATH
- Terminal key `<C-/>` conflicts
  - Remap in your local overrides if your terminal intercepts it

## Credits

Big thanks to the maintainers of Lazy.nvim, Telescope, mason, nvim-lspconfig, blink.cmp, Oil, Harpoon, Treesitter, Snacks, Noice, and the broader Neovim community.

---

If you’re adapting this for your own use, skim `becks/set.lua`, `becks/remap.lua`, and `becks/plugins/` for quick customization. Happy hacking!
