# AGENTS

In all interactions and commit messages, be extremely concise and sacrifice
grammar for the sake of concision.

## Commits

Use Conventional Commits v1.0.0 format:
https://www.conventionalcommits.org/en/v1.0.0/

- Use header format: `type(scope): description`
- Scope is optional, but include it in parentheses when applicable.
- For simple changes, use a single-line commit message with only the header.
- For more involved changes, use a header and a body (separated by a blank
  line).

Simple one-line example:
`fix(auth): handle empty token input`

Header + body example:
```
feat(api): add retry support for transient errors

Retry failed requests with exponential backoff for network timeouts.
Limit retries to three attempts to avoid long blocking operations.
```

## Plans

- At the end of each plan, give me a list of unresolved questions to answer, if
  any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.
