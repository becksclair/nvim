# Repository Guidelines

## Project Structure & Module Organization
- Config root: `init.lua` boots `lua/becks/*` (settings, keymaps, lazy setup, autocmds).
- Core modules: `lua/becks/{set,remap,misc,lazy,autocmds}.lua`.
- Plugins: one file per plugin under `lua/becks/plugins/` (Lazy.nvim spec tables).
- Filetype tweaks: `ftplugin/*`; Treesitter queries: `queries/`.
- Theme helpers: `after/plugin/colors.lua`.
- Mason helpers: `mason-packages.txt`, `install-in-mason` script.

## Build, Test, and Development Commands
- First run/bootstrap: `nvim` then `:Lazy sync` (installs plugins).
- Mason UI/tools: `:Mason` (install LSP/formatters/linters listed in `mason-packages.txt`).
- Headless checks: `nvim --headless "+Lazy! sync" +qa` and `nvim --headless "+checkhealth" +qa`.
- Update plugins: `:Lazy update`; review lockfile changes in `lazy-lock.json`.

## Coding Style & Naming Conventions
- Language: Lua 5.1 (Neovim runtime). Prefer clear, local-scoped functions.
- Indentation: Lua files use 2 spaces (format with stylua via Conform).
- File-per-plugin: `lua/becks/plugins/<name>.lua` exporting a Lazy spec `return { ... }`.
- Names: kebab or plugin-name in filename; use `opts`, `config(_, opts)` patterns.
- Formatting: `:ConformInfo` to inspect; `<F3>` to format current buffer.

## Testing Guidelines
- Smoke tests: open various filetypes; verify LSP attach with `:LspInfo`.
- Lint on write: `nvim-lint` is wired; run `:lua require('lint').try_lint()` or `<leader>bl`.
- CI not provided; keep changes minimal and test with `--headless` commands above.

## Commit & Pull Request Guidelines
- Commit style: Conventional Commits with optional scope/emojis
  - Examples: `feat(lsp): add tsserver`, `fix: guard nil client`, `chore: update packages`.
- PRs should include: purpose, notable UX changes (keymaps/commands), screenshots if UI, and any new external tool requirements.
- Link related issues (if any) and call out breaking changes.

## Security & Configuration Tips
- Do not commit secrets. External tools are resolved via Mason or system PATH.
- Keep `lazy-lock.json` in sync; update deliberately to avoid breakage.
- To share tool sets, export/import Mason packages: `:MasonExport` / `:MasonRestore`.
