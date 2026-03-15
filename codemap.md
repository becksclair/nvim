# nvim/

## Responsibility
- Deliver the user’s full Neovim runtime configuration through a minimal Lua entrypoint and domain-specific config slices.
- Keep startup behavior deterministic (boot order, plugin lifecycle, keymaps, LSP/tooling, themes, and local overrides).

## Design
- `init.lua` is intentionally tiny and delegates setup to `becks/init.lua`.
- `lua/` contains all executable configuration modules and plugin specs.
- `after/plugin/`, `ftplugin/`, and data directories are loaded by Neovim conventions for overrides and language-specific adjustments.
- Static assets (`*.json`, `mason-packages.txt`, `.ox*rc`, `README.md`) configure formatter/linter/tooling behavior.

## Flow
- Startup: `init.lua` -> `require('becks')` in `lua/becks/init.lua`.
- Core boot phase wires core options, keymaps, autocmds, plugin bootstrap, then environment-specific tweaks.
- Plugin orchestration is delegated to Lazy.nvim through `lua/becks/lazy.lua` and the `lua/becks/plugins/*` import.
- Runtime overrides from `after/plugin/` and `ftplugin/` apply after core and plugin setup.

## Integration
- `README.md` documents user-facing behavior and plugin stack decisions.
- `AGENTS.md` references this map so future contributors can navigate the layout quickly.
- `.slim/cartography.json` tracks mapping state for this map workflow.
