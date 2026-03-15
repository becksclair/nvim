# lua/becks/nim/

## Responsibility
- Provide custom Nim-specific runtime behavior that goes beyond a simple `ftplugin`, especially syntax highlighting and indentation logic written in Lua.
- Preserve a self-contained place for Nim overrides without polluting the generic startup modules.

## Design
- `syntax.lua` reimplements Nim syntax groups and highlight links with Neovim's Lua APIs instead of relying on Vimscript runtime files.
- `indent.lua` exposes a Lua `indentexpr` implementation modeled after classic Nim indent rules.
- The syntax override is active through a `FileType nim` hook, while the indent module is present as a ready-made override but is not currently auto-enabled in `autocmds.lua`.

## Flow
- Opening a Nim buffer triggers the Nim filetype path, which leads `lua/becks/autocmds.lua` to call `require("becks.nim.syntax").setup()`.
- `ftplugin/nim.lua` then applies buffer-local editing defaults such as tabs, comments, and suffix completion.
- If the indent module is enabled later, Neovim would call its `get()` function through `indentexpr` for per-line indentation decisions.

## Integration
- Paired directly with `ftplugin/nim.lua` and the Nim autocommand in `lua/becks/autocmds.lua`.
- Reuses standard highlight groups so Nim syntax coloring still follows whichever colorscheme and highlight overrides are active.
- Remains isolated from the general plugin system, which makes Nim behavior easy to adjust without side effects elsewhere.
