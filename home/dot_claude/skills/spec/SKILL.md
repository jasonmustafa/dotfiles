---
name: spec
description: In-depth spec interview - reads SPEC.md and interviews user until complete
argument-hint: [path/to/SPEC.md]
allowed-tools: [Read, Write, Edit, Glob, Grep, AskUserQuestion]
model: opus
---

# Spec Interview Skill

You are conducting an in-depth product/technical specification interview.

## Arguments

$ARGUMENTS - optional path to spec file (defaults to SPEC.md in current directory)

## Process

### 1. Find and Read Existing Spec

First, locate the spec file:

- If argument provided, use that path
- Otherwise, search for SPEC.md in current directory
- If no spec exists, ask user what they're building and create initial structure

Read the entire spec file to understand current state.

### 2. Conduct Deep Interview

Interview the user systematically using AskUserQuestion. Your goal is to surface
non-obvious concerns and fill gaps.

**Interview principles:**

- Ask NON-OBVIOUS questions - things user hasn't considered
- Probe edge cases, failure modes, security implications
- Challenge assumptions respectfully
- Think adversarially - what could go wrong?
- Consider operational concerns (monitoring, debugging, rollback)
- Ask about what happens when things fail, not just happy paths

**Categories to cover (adapt based on spec type):**

**Technical Implementation:**

- Architecture decisions and their tradeoffs
- Data model edge cases (nulls, limits, migrations)
- Concurrency, race conditions, ordering guarantees
- Performance under load, caching invalidation
- API contract versioning, backwards compatibility
- Error propagation, retry semantics, idempotency

**UI/UX (if applicable):**

- Loading, error, and empty states
- Keyboard accessibility, screen readers
- Mobile/responsive edge cases
- Undo/redo, data loss prevention
- Offline behavior
- Internationalization implications

**Security & Privacy:**

- Auth edge cases (session expiry, token refresh)
- Authorization boundaries and escalation paths
- Data retention, deletion, GDPR implications
- Audit logging requirements
- Rate limiting, abuse prevention

**Operations & Reliability:**

- Deployment strategy, feature flags
- Monitoring, alerting thresholds
- Debugging in production
- Rollback scenarios
- Data backup/recovery

**Integration & Dependencies:**

- External service failure handling
- Version compatibility
- Migration paths from current state

**Business Logic:**

- Edge cases in domain rules
- Conflict resolution
- State machine transitions
- Timing/scheduling edge cases

### 3. Interview Flow

- Ask 1-4 questions at a time using AskUserQuestion
- Group related questions together
- After each round, update your mental model
- Probe deeper on interesting/concerning answers
- Continue until:
  - All major sections are covered
  - User indicates they're satisfied
  - No more significant gaps remain

When you identify a gap or decision, note it for the spec.

### 4. Write Final Spec

After interview complete:

1. Synthesize all answers into coherent spec
2. Organize by logical sections
3. Include explicit decisions made during interview
4. Note any open questions that remain
5. Write to the spec file (create or update)

## Output Format

The final spec should include:

- Overview/goal
- Requirements (functional and non-functional)
- Technical decisions with rationale
- Edge cases and how they're handled
- Open questions/future considerations

## Important

- Be relentless about non-obvious questions
- Don't accept vague answers - probe for specifics
- Surface tradeoffs explicitly
- Challenge "we'll figure it out later" with "what if we don't?"
- Think like a skeptical senior engineer doing a design review
