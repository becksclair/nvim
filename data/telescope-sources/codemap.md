# data/telescope-sources/

## Responsibility
- Provide curated symbol/source catalogs for Telescope-driven insertion and lookup workflows.
- Give the editor searchable access to emoji, kaomoji, gitmoji, mathematical symbols, LaTeX commands, Julia-style Unicode mnemonics, and Nerd Font glyph names.

## Design
- Each JSON file is a flat array of `[value, label]` pairs, which keeps the datasets simple to parse and easy to reuse from picker code.
- Files are grouped by semantic domain instead of plugin internals: `emoji.json`, `gitmoji.json`, `kaomoji.json`, `math.json`, `latex.json`, `julia.json`, and `nerd.json`.
- Large catalogs stay as static assets here rather than inflating Lua plugin files with giant embedded tables.

## Flow
- A symbol picker selects one of these sources, loads the corresponding JSON file, and renders the entries through Telescope.
- Users search by either the symbol itself or its descriptive text, then insert or copy the result from the picker UI.

## Integration
- Primarily supports the Telescope symbols workflow exposed by `lua/becks/plugins/telescope.lua` and the `telescope-symbols.nvim` dependency.
- Benefits from the highlight customization in `after/plugin/colors.lua`, which styles Telescope's picker UI after the data has been loaded.
- Forms the largest static-data surface in the repo and is documented from `data/codemap.md` and the root map.
