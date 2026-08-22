---
name: steal-pattern
description: Extract an architectural pattern from the current codebase into a portable, graftable spec. Identifies essence vs incidentals, captures roles and invariants, and writes a self-contained markdown file you can hand to a different project to re-implement the pattern without dragging this codebase's specifics along.
allowed-tools: AskUserQuestion, Read, Glob, Grep, Bash(git log:*), Bash(git show:*), Bash(rg:*), Bash(ls:*), Bash(mkdir -p:*), Write, Edit, Agent
disable-model-invocation: true
---

# Steal Pattern

Take a real pattern living in the current codebase — a way classes, modules, or files coordinate — and write it down so a different codebase can re-implement it without inheriting this codebase's specifics. The output is a recipe, not a transplant.

Output: `./docs/patterns/<slug>.md` (override only if the user passed an explicit path).

## Phase 1 — Pin the pattern

A vague target ("we have a good plugin system") produces vague output. Restate the user's target in one sentence. If the scope is ambiguous, use `AskUserQuestion` once with 2–3 concrete interpretations plus Other.

Well-scoped targets look like:

- "Resolver → Facade → Service layering inside the reference plugin."
- "How the shared table component orchestrates pagination via a store."
- "Domain-plugin boundaries — how plugins isolate state and communicate via DTOs."
- "How the dev CLI dispatches to subcommands and discovers them."

Patterns. Not features, not bug fixes.

## Phase 2 — Explore (read-only)

Read the actual code, not what you expect to be there. Roughly:

1. Find the anchor file(s) via `Glob` / `Grep`.
2. Read the canonical instance — usually the cleanest or freshest, the one the README points at.
3. Read 1–2 more instances to confirm what's invariant vs incidental.
4. `git log -- <paths>` on the anchor — refactor/revert commits hint at what's load-bearing.
5. Skim README / ADR / CLAUDE.md mentions to catch the documented intent.

For wide patterns, delegate the read to `Agent` with `subagent_type: Explore` and have it return: roles, invariants, ≥2 concrete examples, and observed variants. Don't have it write the pattern file.

Maintain two private lists:

- **Essence** — the roles, rules, and invariants the pattern needs to work.
- **Incidentals** — names, frameworks, paths, language features, project conventions that happen to surround the pattern here but aren't part of it.

## Phase 3 — Write the pattern file

Self-contained. A reader who has never seen the source codebase should be able to graft from it.

Hard rules:

- **Roles, not classes.** Write "a resolver that maps GraphQL input to a facade call" — not "`CustomerResolver extends BaseResolver`".
- **Examples are illustrative, not authoritative.** Show 1–2 short, trimmed snippets to make the shape concrete; mark them "in the source codebase, this looks like…". Strip names that only mean something here.
- **State invariants explicitly.** What must hold for the pattern to keep working? Where does it break?
- **Call out substitution points.** What changes when grafting — language, framework primitives, naming, persistence, transport.
- **Don't smuggle source vocabulary.** If the pattern lives in a CakePHP plugin, the spec should not assume CakePHP. Frameworks become *requirements* ("needs a DI container"), not givens.
- **Lessons that didn't ship are still lessons.** Note variants the source tried and rejected — saves the graft from rediscovering dead ends.

### Template

```markdown
# <Pattern Name>

> Stolen from <repo>/<paths> on <YYYY-MM-DD>.

## Intent

One paragraph: what problem this pattern solves, and what shape of solution it commits to.

## Roles

Each participant and what it's responsible for. Name by role.

- **<Role>**: <responsibility>. Knows about <X>, doesn't know about <Y>.

## Invariants

The rules that must hold. If broken, the pattern degrades into the thing it was avoiding.

## Shape (illustrative)

Short anonymized sketch — pseudocode or trimmed real code — showing how the roles wire together. Marked illustrative, not prescriptive.

## Substitution points

What changes when grafting. Be explicit about language, framework primitives, naming, persistence, transport.

## When to use / not use

Two short lists. When the pattern earns its complexity, and when it's overkill.

## Lessons from the source

Variants tried and rejected, edges that bit, places the pattern was over-applied. Saves the graft from re-learning.
```

## Phase 4 — Report

Print the output path and a one-line summary: pattern name, anchor file(s) read, and the 2–3 substitution points the user should think about hardest before grafting.

## Anti-patterns

- Pasting source code wholesale. The output is a spec, not a transplant.
- Inventing roles or invariants the code doesn't actually have. If you can't point to a file, don't write the rule.
- Letting source framework/vocabulary leak ("the resolver extends `BaseResolver`"). Restate as a role requirement.
- Writing the file after reading one example. One example is an anecdote, not a pattern — confirm against ≥2.
- Asking the user lots of questions. Pin the scope once, then go.
