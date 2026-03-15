# lua/becks/plugins/

## Responsibility
- Hold the full plugin inventory as one-file-per-plugin Lazy.nvim specs, covering editing UX, LSP, completion, formatting, linting, navigation, Git tooling, themes, and language helpers.
- Keep each plugin's loading conditions, dependencies, options, keymaps, and setup logic close to the plugin that owns them.

## Design
- Every file returns a Lazy.nvim spec table, which keeps the folder composable and lets `lazy.lua` import the directory as a package.
- High-traffic subsystems are broken out into dedicated files such as `lsp.lua`, `telescope.lua`, `treesitter.lua`, `conform.lua`, `nvim-lint.lua`, `mason-tool-installer.lua`, `oil.lua`, and `noice.lua`.
- Theme plugins are isolated as their own specs, while actual highlight overrides stay in `after/plugin/colors.lua` so colorscheme selection and custom polish are decoupled.
- Most specs prefer lazy events, commands, or keys, but core infrastructure like Mason and LSP boot eagerly when editor startup needs them available immediately.

## Flow
- Lazy.nvim imports this directory and evaluates each returned spec during startup.
- Individual specs register plugin-specific keymaps, autocommands, commands, and option tables when their load conditions fire.
- Cross-plugin workflows are assembled here: Mason installs tools, LSP attaches capabilities, Telescope exposes pickers, Conform formats buffers, and nvim-lint runs diagnostics after writes.

## Integration
- Imported exclusively by `lua/becks/lazy.lua`, but depends on global settings and helpers from `lua/becks/`.
- Pulls in external data from `mason-packages.txt`, `data/telescope-sources/`, `.oxfmtrc.json`, `.oxlintrc.json`, and theme/highlight helpers in `after/plugin/colors.lua`.
- Complements `ftplugin/` and `lua/becks/autocmds.lua` by attaching richer runtime behavior after filetype detection and plugin load.
