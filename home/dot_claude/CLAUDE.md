# CLAUDE

In all interactions and commit messages, be extremely concise and sacrifice
grammar for the sake of concision.

## Commits

Use conventional commits style (type(scope): description) unless repo uses
different convention or otherwise instructed.

## Plans

- At the end of each plan, give me a list of unresolved questions to answer, if
  any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.

## Nerd Font Glyphs

When editing lines containing Nerd Font icon glyphs:

- Only modify necessary characters around the glyph, never rewrite it
- Use `replace_all` on safe substrings when bulk renaming
- If glyph itself needs changing, use placeholder `X` with comment:
  `"X "  # f120 - terminal`
