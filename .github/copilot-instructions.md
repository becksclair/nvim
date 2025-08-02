# Neovim Configuration Copilot Instructions

This is a personal Neovim configuration using Lazy.nvim plugin manager with a modular, file-per-plugin architecture.

## Architecture Overview

**Entry Point**: `init.lua` → `lua/becks/` (main module)
- `becks/init.lua`: Core initialization order: settings → keymaps → plugin manager → autocmds → neovide
- `becks/lazy.lua`: Lazy.nvim setup with plugin auto-import from `becks.plugins` directory
- Each plugin gets its own file in `lua/becks/plugins/` following the pattern: `return { 'plugin/name', config = ... }`

**Core Module Structure**:
- `becks/set.lua`: Vim options, OS detection utilities, cross-platform compatibility
- `becks/remap.lua`: Key mappings (leader = space, clipboard integration, movement enhancements)
- `becks/autocmds.lua`: Auto-commands for formatting, LSP tweaks, filetype handling
- `becks/conditions.lua`, `becks/icons.lua`, `becks/misc.lua`: Shared utilities

## Plugin Management Patterns

**Lazy Loading Strategy**: Most plugins use `event = "VeryLazy"` or specific trigger events
**Plugin File Template**:

```lua
return {
  'author/plugin-name',
  dependencies = { 'required-deps' },
  event = "VeryLazy", -- or cmd/keys/ft
  opts = { ... }, -- for simple configs
  config = function() ... end -- for complex setups
}
```

**Key Plugins**:

- **Telescope**: Fuzzy finder with custom layouts, symbol integration, custom data sources in `data/telescope-sources/`
- **LSP**: Mason + lspconfig with cross-platform binary handling, custom server configs in `nlsp-settings/`
- **Treesitter**: Syntax highlighting with custom queries in `queries/` directory
- **Harpoon v2**: File navigation with telescope integration
- **Oil.nvim**: File explorer (replaces netrw)

## Development Workflows

**Plugin Development**:

- Add new plugins as separate files in `lua/becks/plugins/`
- Use the `R("module.name")` function (defined in `becks/init.lua`) for hot-reloading during development
- Lazy.nvim auto-imports anything in the `becks.plugins` namespace

**Language-Specific Configs**: 

- Filetype settings in `ftplugin/` (e.g., `lua.lua` sets expandtab for Lua files)
- Custom language support via Treesitter queries and LSP configurations

**Color Scheme Management**:

- `after/plugin/colors.lua`: Centralized theme switching with `ColorMyPencils()` function
- Custom highlight groups for Telescope, visual selections, and plugin integrations
- Light/dark mode detection with conditional styling

## Key Conventions

**Cross-Platform Compatibility**: OS detection utilities in `set.lua`, conditional build scripts
**Plugin Organization**: One plugin per file, grouped by functionality (LSP, Git, UI, etc.)
**Keymap Patterns**: 

- Leader key mappings for main functions (`<leader>pv` for file explorer)
- Harpoon uses `<C-g>`, `<C-t>`, `<C-n>`, `<C-s>` for quick file switching
- Clipboard integration: `y`/`p` use system clipboard by default

**Custom Data**: 

- Telescope symbol sources in `data/telescope-sources/` (emoji, gitmoji, latex symbols)
- Spell checking dictionary in `spell/en.utf-8.add`
- Mason tool installation script: `install-in-mason` for containerized environments

## Integration Points

**External Tool Dependencies**: Mason handles LSP servers, formatters, linters with auto-installation
**Terminal Integration**: Kitty-specific plugins for navigation and scrollback
**AI/LLM Integration**: ChatGPT, Copilot, and Avante plugins configured
**Git Workflow**: Fugitive, Gitsigns, Neogit, Diffview for comprehensive Git integration

When modifying this config, follow the established patterns: create separate plugin files, use appropriate lazy loading, and maintain cross-platform compatibility.
