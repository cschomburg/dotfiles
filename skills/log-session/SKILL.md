---
name: log-session
description: Write a session note summarizing notable work (what changed, details, learnings) so the next session doesn't re-walk the same rabbit hole. Use after a gnarly debugging session, a non-obvious setup, or any work worth not re-treading.
---

# log-session

Capture what was just done into a dated session note so the next session (human
or agent) doesn't re-walk the same rabbit hole.

## Steps

1. **Discover the repo's convention first.** Look for an existing session/log
   directory and copy its layout — don't impose a new one. Check, in order:
   - `ls docs/sessions docs/session docs/logs docs/log logs log notes 2>/dev/null`
     (also check `CLAUDE.md`/`AGENTS.md`/`README` for a documented location).
   - If one exists, match its **directory, filename pattern, and section
     structure** by reading the most recent note there. Follow that, not the
     template below.
2. **Fall back** only if no convention exists: create
   `docs/sessions/<iso-date>-<slug>.md`, where `<iso-date>` is today
   (`YYYY-MM-DD`) and `<slug>` is a short kebab-case summary of the work
   (e.g. `2026-06-27-tailscale-per-service-dns`), using the template below.
3. Keep it succinct and skimmable. Prefer concrete commands, paths, and the
   *non-obvious* over narration. The **Learnings** section is the point — write
   the things that cost time or surprised you.

## Template

```markdown
# <ISO date> — <Title>

> One-line TL;DR of what changed and why it mattered.

**Status:** done | partial (see Follow-ups) | abandoned

## What

What prompted this (the trigger/goal), then the outcome — what now works/exists
that didn't before, and where it lives. One short paragraph or a few bullets.

## Details

How it actually fits together: the moving pieces, key files/commands, and the
commits. Enough for someone to find and modify it later. Bullets over prose.

## Learnings

The hard-won bits. Each: a claim, then why it bit / how to avoid it.
- Tools/flags that don't exist or behave unexpectedly.
- Misleading output or error messages, and the real source of truth.
- Ordering/dependency gotchas.
- Dead-ends and red herrings — what you chased and ruled out, in order, so
  nobody re-chases them.
- What is NOT possible (so nobody retries it).

## Follow-ups (optional)

Loose ends deliberately left undone.
```

## Notes

- One file per session; don't append to old ones.
- These notes are institutional memory — cross-link related runbooks/docs when
  relevant.
