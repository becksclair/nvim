# lua/becks/

## Responsibility
- Define the main application namespace for the Neovim config: startup order, editor defaults, keymaps, helper commands, plugin bootstrap, GUI tweaks, and language-specific overlays.
- Provide the modules that turn a minimal `require("becks")` entrypoint into a full editor runtime.

## Design
- `init.lua` is the orchestrator and keeps the boot order explicit: settings, remaps, misc helpers, Lazy.nvim, autocmds, then Neovide support.
- Each core concern lives in a focused file instead of a monolithic config blob, which keeps behavior discoverable and makes plugin-specific changes local.
- `misc.lua` holds reusable helpers and user commands, `lazy.lua` owns package-manager setup, and `plugins/` is treated as a sibling subsystem rather than inline config.
- `nim/` is a targeted override area for language behavior that needs more than a couple of buffer-local options.

## Flow
- `lua/becks/init.lua` requires the core modules in order, then registers startup autocommands such as yank highlighting and trailing-whitespace cleanup.
- `set.lua` establishes editor defaults and filetype detection, `remap.lua` layers in global and language-triggered mappings, and `autocmds.lua` adds save hooks and filetype reactions.
- `lazy.lua` hands plugin loading to Lazy.nvim, which later evaluates the specs in `lua/becks/plugins/`.
- Optional GUI behavior in `neovide.lua` applies only when Neovide globals are present.

## Integration
- Feeds plugin setup through `lua/becks/plugins/` and consumes helper behavior from `after/plugin/colors.lua`, `ftplugin/`, and static config files at the repo root.
- Exposes user-facing commands such as Mason export/restore and sudo-write helpers that are referenced by mappings and runtime workflows.
- Anchors the nested maps for `lua/becks/plugins/codemap.md` and `lua/becks/nim/codemap.md`.
