---
name: kickoff
description: Kick off a new project from a rough idea. Clarifies intent, estimates scope/complexity tier, interviews the user with a handful of focused questions, writes a PRODUCT_BRIEF.md, then proposes a tech stack and scaffolds the repo with initial stubs. Use when starting a greenfield project, turning an idea into a brief, or bootstrapping a new repo.
---

# kickoff

Turn a rough idea into a shared understanding and a scaffolded repo. The job is to get *just enough* clarity to start well — not to spec the whole product. Right-size everything to the project's tier: a weekend CLI gets a one-paragraph brief and a single `main.go`; a real web service gets a proper brief, a stack decision, and a layered skeleton.

Move in five steps, in order. Don't scaffold before the brief is confirmed, and don't write the brief before the interview.

## Process

### 1. Capture intent

If the user already described what they want to build, restate it in one or two sentences and move on. If not, ask the single opening question: **"What do you want to build, and why?"** Don't proceed without an answer — everything downstream hangs on it.

### 2. Guess the tier

From the intent alone, make a first estimate of scale/complexity using the following tiers:

1. **Simple** — personal script, hobby tool, one user, one developer.
2. **Medium** — a real web service: backend + frontend, persistent data, a few users/contributors, deployed somewhere.
3. **High** — multiple services or bounded domains, several teams, inter-service communication.
4. **Enterprise** — commercialized / multi-tenant SaaS, with monetization, compliance, and scale concerns.

State your guess and the one-line reasoning ("Sounds like Tier 2 — a deployed web app with a DB, solo dev"). When ambiguous, guess **low** and let the interview correct upward. The tier sets how heavy everything that follows should be.

### 3. Interview

Ask **3–10 focused follow-up questions** to close the gaps between the intent and a buildable brief. Scale the count to the tier: ~3 for Tier 1, up to ~10 for Tier 3–4. Prefer the `AskUserQuestion` tool with concrete options so the user can pick fast; fall back to prose for genuinely open questions.

Cover the dimensions that are actually uncertain — don't ask what intent already answered:

- **Users & use** — who uses it, what's the core job, what does success look like for them?
- **Scope boundary** — what's explicitly *in* v1 and what's deferred? (The most valuable question — pin down the smallest useful thing.)
- **Success criteria** — how will *you* know it's working? A metric, a demo, a "I use it daily."
- **Constraints** — deadline, hosting target, existing systems to integrate, team size, budget.
- **Data & state** — what's persisted, where, any privacy/compliance angle (bumps the tier if yes).
- **Interface** — CLI, web, API, TUI, mobile? Drives the stack.

Update the tier guess if answers reveal more (or less) than expected, and say so. Stop once you can write each brief section without guessing — don't pad to hit a number.

### 4. Write PRODUCT_BRIEF.md

Synthesize the interview into `PRODUCT_BRIEF.md` at the repo root, using the format below. Keep it tight — a brief nobody rereads is wasted. Echo it back and let the user correct before scaffolding.

```markdown
# {Project Name}

> {One-sentence pitch — what it is and for whom.}

**Tier:** {1–4} ({Simple|Medium|High|Enterprise})

## Problem

{What's broken or missing today, and why it's worth solving. 2–4 sentences.}

## Users

{Who this is for and the core job they're hiring it to do. Name the primary user; note secondary ones if real.}

## Scope

**In (v1):**
- {The smallest set that delivers the core value.}

**Out (for now):**
- {Explicitly deferred — names the boundary so scope creep is visible.}

## Success criteria

- {Concrete, checkable signals the project is working — a metric, a demo, an adoption bar.}

## Constraints

- {Deadlines, hosting, integrations, team, budget — whatever bounds the solution. Omit if none.}

## Open questions

- {Unknowns to resolve as you build. Honest > empty. Omit if genuinely none.}
```

### 5. Propose stack, confirm, scaffold

Recommend a stack, defaulting to the **house stack** below unless the project clearly wants otherwise (say why if you deviate). Present it, get an explicit confirmation via `AskUserQuestion`, then scaffold.

**House stack (opinionated default):**
- **Tooling:** [devenv](https://devenv.sh/) + [Nix](https://nixos.org/) for a reproducible dev environment — `devenv.nix`, `devenv.yaml`, and a `.envrc` (`use devenv`) for direnv.
- **CLI / backend:** Go.
- **Frontend:** TypeScript on [Vite+](https://viteplus.dev/llms-full.txt). [daisyui](https://daisyui.com/SKILL.md) for UI components.
- **Database**: SQLite for small projects, postgres otherwise.

Pick the slice that fits the interface: a CLI tool is Go-only; a web app is Go backend + Bun/TS frontend; a static or frontend-only thing is Bun/TS alone.

Once confirmed, scaffold a **tier-appropriate** skeleton. Keep stubs minimal but runnable — enough that the first `devenv shell` + build/run works end to end. Then print next steps.

**Always:**
- `git init` if not already a repo; a `.gitignore` for the chosen languages.
- `README.md` — name, one-line pitch, and a one-command setup/run section.
- `AGENTS.md` — build/test/run commands and conventions, so an agent (or new dev) can work the repo. [agents.md](https://agents.md/)
- `PRODUCT_BRIEF.md` (from step 4).
- `devenv.nix` declaring the language toolchains (go, bun) and any services (e.g. postgres for Tier 2+).

**Scale the rest by tier:**
- **Tier 1:** one source file with a working entrypoint (`main.go` printing/doing the core thing), and a build/run line in the README. Stop here — no layers, no CI.
- **Tier 2:** layered backend (`cmd/`, `internal/{domain,http,store}/` for Go), a `frontend/` Bun app stub if there's a UI, a `.github/workflows/ci.yml` running lint + test + build, and a `docs/adr/` with a first ADR recording the stack choice. Add a `CONTEXT.md` stub for the domain model.
- **Tier 3+:** a directory per bounded context, a root `CONTEXT-MAP.md`, and per-service skeletons. Don't fully build it — scaffold the structure and leave a clear TODO trail. Flag that this much structure deserves its own design pass.

After scaffolding, verify the happy path builds (run the build/test command), then output a short **Next steps** list (3–5 concrete first tasks) and point at the open questions from the brief.

## Guidelines

- **One step at a time.** Intent → tier → interview → brief → stack → scaffold. Each gate confirmed before the next; never jump ahead to code.
- **Right-size relentlessly.** The most common failure is Tier-3 ceremony on a Tier-1 idea. When in doubt, build less; it's cheaper to add structure than to delete it.
- **Smallest useful v1.** Push the scope boundary toward the minimal thing that delivers the core value. Defer everything else to "Out (for now)" rather than arguing it away.
- **Don't over-interview.** Stop asking once the brief is writable. Questions are for genuine uncertainty, not a checklist to complete.
- **Stubs must run.** A scaffold that doesn't build is worse than no scaffold. Verify the entrypoint before declaring done.
- **Hand off cleanly.** The deliverable is a confirmed brief + a runnable skeleton + a next-steps list — a foundation a follow-up session (or [[architecture-audit]] later) can build on.
