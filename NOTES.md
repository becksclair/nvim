# NOTES.md
## Patterns
- [2026-02-20] For this Neovim config repo, contributor docs should map directly to `lua/becks/` + `lua/becks/plugins/` and include headless Neovim verification commands.

## Pitfalls
- [2026-02-20] No formal test harness exists; claiming unit/integration test commands in guides is misleading. Prefer runtime validation commands.
- [2026-02-20] Any extra `*.lua` file under `after/plugin/` is auto-sourced by Neovim; sync-conflict copies can silently override runtime behavior (for example theme selection).

## Decisions
- [2026-02-20] Commit guidance follows observed Conventional Commit prefixes in local history (`feat`, `fix`, `chore`, `docs`) with optional scopes.

## Proven Commands / Checks
- `git log --pretty=format:'%h %s' -n 40` - verified commit message conventions for this repo.
- `wc -w AGENTS.md` - verified contributor guide length target (200-400 words).
- `fd -HI 'sync-conflict|conflict' .` - fast scan for Syncthing/merge conflict files in this repo.
- `nvim --headless "+lua ...getscriptinfo()..." +qa` - confirms which `after/plugin/colors*` files are sourced at startup.

## Pruned / Superseded
- None yet.
