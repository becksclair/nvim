# after/plugin/

## Responsibility
- Apply late plugin/runtime overrides after the main config has loaded; in practice this folder centralizes theme switching and highlight polish.
- Keep user-facing colorscheme commands and highlight patching out of individual plugin spec files.

## Design
- `colors.lua` is the single source of truth for theme commands such as `SetTheme`, `SetMelange`, `SetTokyoNightStorm`, and other named variants.
- Shared helper functions (`ColorMyPencils`, `SetMyColorHls`) let multiple theme commands reuse the same Telescope, Visual, IncSearch, and completion highlight adjustments.
- Theme plugin installation stays in `lua/becks/plugins/`, while this folder handles the opinionated "last mile" appearance.

## Flow
- When Neovim reaches `after/plugin/colors.lua`, it defines theme commands, applies the default colorscheme, and conditionally re-applies theme choice outside the Linux virtual console.
- Theme commands switch colorschemes first and then patch highlight groups so the UI stays consistent across different palettes.
- The file also exports commands that Neovide and manual user workflows can reuse later in the session.

## Integration
- Depends on colorscheme plugins declared in `lua/becks/plugins/` and helper logic in `lua/becks/misc.lua`.
- Shapes the appearance of Telescope and completion UI configured elsewhere, especially in `lua/becks/plugins/telescope.lua` and completion-related specs.
- Acts as the repo's late-stage visual customization layer referenced by `README.md` and the root codemap.
