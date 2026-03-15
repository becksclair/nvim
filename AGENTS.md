# Repository Guidelines

## Project Structure & Module Organization
- Entry point: `init.lua` loads `lua/becks/init.lua`, which initializes settings, mappings, plugin setup, autocmds, and Neovide options.
- Core config lives in `lua/becks/` (`set.lua`, `remap.lua`, `autocmds.lua`, `misc.lua`, etc.).
- Plugin definitions are one-file-per-plugin in `lua/becks/plugins/` and are auto-imported by Lazy.nvim.
- Filetype overrides live in `ftplugin/` (for example `ftplugin/lua.lua`, `ftplugin/go.lua`).
- Theme/highlight overrides live in `after/plugin/colors.lua`.
- Supplemental assets/config live in `queries/`, `data/telescope-sources/`, `nlsp-settings/`, and `mason-packages.txt`.

## Repository Map
- Start with `codemap.md` for the repo-level layout and runtime flow.
- Follow `lua/codemap.md` and `lua/becks/codemap.md` for core startup and module boundaries.
- Use `lua/becks/plugins/codemap.md` for the plugin inventory and cross-plugin integration points.
- Use `after/codemap.md` and `after/plugin/codemap.md` for late theme/highlight behavior.
- Use `ftplugin/codemap.md` and `lua/becks/nim/codemap.md` for filetype-specific overrides.
- Use `data/codemap.md`, `data/telescope-sources/codemap.md`, and `nlsp-settings/codemap.md` for static assets and external server config.

## Build, Test, and Development Commands
- `nvim` - starts Neovim and bootstraps/syncs plugins through Lazy.nvim if needed.
- `nvim --headless "+Lazy! sync" +qa` - syncs plugins and updates lock state.
- `nvim --headless "+MasonRestore" +qa` - restores Mason tools listed in `mason-packages.txt`.
- `nvim --headless "+checkhealth" +qa` - runs Neovim health checks for providers/tools.
- `./install-in-mason <tool-name>` - links externally installed tools into Mason paths (mainly containerized setups).

## Coding Style & Naming Conventions
- Use Lua with file-local, readable configuration; avoid large monolithic plugin files.
- Preserve existing indentation and spacing in touched files (most Lua config uses 2-space indentation).
- Keep plugin files descriptive and focused (for example `lua/becks/plugins/telescope.lua`).
- Follow existing Lazy.nvim spec patterns: `return { ... }` tables with explicit `dependencies`, `event/cmd/keys`, and `opts/config`.

## Testing Guidelines
- There is no formal unit test suite in this repo; validation is runtime-focused.
- For config changes, verify startup and module load: `nvim --headless "+lua require('becks')" +qa`.
- For plugin/keymap changes, open Neovim and test the affected workflow manually (for example Telescope, LSP attach, format/lint actions).

## Commit & Pull Request Guidelines
- Follow the observed Conventional Commit style from history: `feat: ...`, `fix: ...`, `chore: ...`, `docs: ...`, with optional scopes (for example `feat(neotree): ...`).
- Keep commits narrowly scoped (one plugin or one behavior change per commit).
- PRs should include: intent, notable config/runtime impact, verification steps run, and screenshots/GIFs for UI/theme changes.
- If behavior or commands change, update `README.md` in the same PR.
