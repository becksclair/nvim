# lua/

## Responsibility
- Host the executable Lua side of the Neovim config, from the top-level `require("becks")` entrypoint to all core modules and Lazy.nvim plugin specs.
- Keep startup logic, reusable helpers, plugin declarations, and language-specific Lua overrides under a single namespace rather than scattering logic across runtime directories.

## Design
- `init.lua` delegates immediately into the `becks/` namespace, so the real application code lives under `lua/becks/`.
- Core behavior is split by concern (`set.lua`, `remap.lua`, `lazy.lua`, `autocmds.lua`, `misc.lua`, `neovide.lua`) while plugin specs stay isolated in `lua/becks/plugins/`.
- Language-specific Lua overlays that are richer than a tiny `ftplugin` live beside the core modules, such as `lua/becks/nim/`.

## Flow
- Startup begins at `init.lua`, which loads `lua/becks/init.lua` and triggers the core boot sequence.
- `lua/becks/lazy.lua` bootstraps Lazy.nvim, then imports the plugin spec package from `lua/becks/plugins/`.
- Helper modules and filetype-specific Lua code are consumed later by runtime hooks, plugin configs, and Neovim autocmds.

## Integration
- Works with `after/plugin/` for late highlight and theme overrides and with `ftplugin/` for buffer-local filetype settings.
- Consumes and coordinates static assets from `data/`, `nlsp-settings/`, and `mason-packages.txt` through plugin and helper modules.
- Acts as the implementation layer described by `codemap.md`, `README.md`, and the nested codemaps in this subtree.
