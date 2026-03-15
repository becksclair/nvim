# after/

## Responsibility
- Hold runtime overrides that must load after the main config and plugin runtime files, using Neovim's native `after/` semantics.
- Provide a clean late-binding layer for tweaks that should not live inside plugin specs themselves.

## Design
- The folder is intentionally small and currently delegates all real behavior to `after/plugin/`.
- Keeping late overrides here avoids mixing colorscheme polish and post-load adjustments into the earlier startup modules.

## Flow
- Neovim processes the normal runtime first, then loads files under `after/`.
- In this repo that means the primary late-loading behavior comes from `after/plugin/colors.lua`.

## Integration
- Complements `lua/becks/plugins/` by handling theme and highlight behavior after colorscheme plugins are available.
- Works alongside `lua/becks/neovide.lua` and the broader UI stack without forcing those modules to own late highlight overrides.
- Serves as the parent map for `after/plugin/codemap.md`.
