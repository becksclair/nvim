# ftplugin/

## Responsibility
- Apply buffer-local defaults for specific filetypes without polluting the global editor settings in `lua/becks/set.lua`.
- Capture small, language-focused adjustments such as indentation width, tab behavior, comments, and suffix completion.

## Design
- Most files are intentionally tiny and only override the local options that differ from the repo-wide defaults.
- Closely related languages share similar rules through separate files instead of indirection, which keeps each buffer's behavior obvious.
- `nim.lua` is the main exception: it includes a more complete ftplugin lifecycle guard and richer local configuration.
- An empty `ocaml.lua` keeps the filetype hook available without currently changing defaults.

## Flow
- Filetype detection from Neovim, `set.lua`, and installed plugins selects a filetype.
- Neovim then loads the matching `ftplugin/*.lua`, layering buffer-local options over the global defaults already set during startup.
- Separate autocommands in `lua/becks/remap.lua` and `lua/becks/autocmds.lua` can add build keys or save hooks on top of these local settings.

## Integration
- Extends `lua/becks/set.lua` filetype mappings and works in parallel with plugin-driven behavior like formatting, linting, and Treesitter.
- Nim buffers combine this folder with the dedicated modules in `lua/becks/nim/`.
- Helps keep language ergonomics local while `lua/becks/remap.lua` handles broader workflow shortcuts.
