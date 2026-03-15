# nlsp-settings/

## Responsibility
- Keep checked-in JSON configuration for language-server behavior that does not naturally belong inside the Lua boot code.
- Preserve repo-local server metadata for SQL workflows and similar external-tool settings.

## Design
- The folder currently contains a single `sqlls.json` file in the traditional `nlsp-settings` shape.
- This keeps connection and lint-rule details out of `lsp.lua`, which would otherwise mix machine- or project-specific SQL metadata into the main LSP bootstrap.
- With the current config, the folder is more of a stored settings surface than an actively imported subsystem, because `neoconf` has `nlsp` import disabled.

## Flow
- `sqlls.json` declares the SQL language server command, SQL filetypes, connection details, and lint rules for specific project paths.
- The file does not execute anything by itself; it becomes relevant only if a consumer reads this layout or the repo re-enables `nlsp`-style imports later.

## Integration
- Sits beside `lua/becks/plugins/lsp.lua` as external server configuration rather than inline Lua.
- Complements `ftplugin/sql.lua` and SQL lint/format tooling configured elsewhere in the repo.
- Gives future maintainers a documented place for server-specific JSON config even though current startup relies mainly on Lua and `neoconf`.
