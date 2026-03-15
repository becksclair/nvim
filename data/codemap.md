# data/

## Responsibility
- Store static data files that plugins can consume at runtime without embedding large tables directly into Lua config.
- Keep curated symbol catalogs and other repo-owned assets versioned alongside the editor config.

## Design
- The folder is data-first: JSON assets live here, while the code that presents them stays in `lua/becks/plugins/`.
- `telescope-sources/` is the primary subtree and groups symbol/search datasets by domain rather than by code module.
- This split keeps plugin files smaller and makes big lookup tables easy to refresh independently of plugin logic.

## Flow
- Plugin code loads these files only when a feature needs them, so the data is effectively dormant at startup.
- The main current use case is symbol-style pickers, where Telescope reads a selected dataset and turns it into searchable entries.

## Integration
- Feeds `lua/becks/plugins/telescope.lua` and the `telescope-symbols` workflow with curated symbol catalogs.
- Complements root-level config files like `mason-packages.txt` and `.ox*rc.json`, but stays purely static and read-only from the editor's perspective.
- Serves as the parent map for `data/telescope-sources/codemap.md`.
