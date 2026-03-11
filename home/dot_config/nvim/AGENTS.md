# AGENTS.md

Guidance for agents working in `home/dot_config/nvim` (chezmoi source for `~/.config/nvim`).

## Overview

This is a small Lua Neovim config split by concern:

- `init.lua`: entrypoint; sets `mapleader`, loads config modules, applies `catppuccin-mocha`, loads optional `config.local`.
- `lua/config/options.lua`: editor options.
- `lua/config/plugins.lua`: plugin declarations and setup (built-in `vim.pack`).
- `lua/config/lualine.lua`: lualine statusline config (mode map, Catppuccin theme, section layout). Contains Nerd Font glyphs — see editing rules.
- `lua/config/lsp.lua`: enabled LSP servers, server-specific config, and LspAttach keymaps.
- `lua/config/keymaps.lua`: keymaps and small helper functions.
- `lua/config/local.lua`: optional work-machine overrides (chezmoiignored, not in git). Can add plugins via `vim.pack.add()`, LSP servers, keymaps.

## Validation Commands

Run from this directory unless noted:

```bash
nvim --headless "+qa"                       # startup/syntax sanity check
nvim --headless "+checkhealth" "+qa"        # deeper environment checks
chezmoi diff                                # preview rendered home changes (run from chezmoi source root)
chezmoi apply ~/.config/nvim                # apply only nvim config
```

## Plugin Conventions

- Plugins are declared in `lua/config/plugins.lua` with `vim.pack.add({ ... })`.
- All mini.* modules come from a single `echasnovski/mini.nvim` package (not separate `nvim-mini/mini.*` repos).
- Keep plugin setup in the same file unless a plugin grows large enough to justify its own module.
- Keep existing UX conventions unless asked otherwise:
  - Catppuccin Mocha theme
  - Rounded floating borders
  - Snacks picker as primary picker UI
- If a plugin needs external tools, add a short note near its setup (example: `ripgrep` for Snacks grep, optional Rust build for `blink.cmp` fuzzy backend).

## LSP Conventions

- Enable servers via `vim.lsp.enable({ ... })` in `lua/config/lsp.lua`.
- Add server-specific settings with `vim.lsp.config("<server>", { ... })`.
- Prefer minimal server config and avoid broad global behavior changes unless requested.

## Keymap Conventions

- Leader is space (`vim.g.mapleader = ' '`).
- Put user-facing mappings in `lua/config/keymaps.lua`.
- Preserve existing mnemonic leader groups where possible (`<leader>f` files, `<leader>g` grep, `<leader>s*` search, `<leader>l*` LSP).

## Editing Rules

- Make targeted edits; do not rewrite unrelated sections.
- Keep Lua style consistent with surrounding code in each file.
- Do not add a new plugin manager, lockfile workflow, or framework without explicit request.
