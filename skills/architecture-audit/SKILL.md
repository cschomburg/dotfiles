---
name: architecture-audit
description: Audit a codebase's architecture and engineering practices against tiered best-practice checklists. First classifies the project's size/complexity and structural style (monolith, modular monolith, microservices, etc.), then scans for the principles that matter at that tier, and outputs findings plus prioritized recommendations. Use when the user wants an architecture review, a maturity assessment, or a "what should we improve" survey of a repo.
---

# architecture-audit

Assess how well a codebase's architecture and engineering practices fit its actual complexity, then recommend what to add or fix. The goal is **right-sized** architecture: a hobby script shouldn't carry enterprise ceremony, and a multi-team SaaS shouldn't run on a single `main.py`. Findings are judged against the tier the project is *in*, not the most elaborate tier imaginable.

## Process

1. **Classify the project.** Determine its tier and structural style before evaluating anything (see *Classification*). State your reasoning — the tier sets the entire checklist.
2. **Scan against the tier's checklist.** Tiers are **cumulative**: a Tier 3 project is held to Tiers 1–3. Check each principle against the actual code/config, not the README's claims. Note what exists, what's missing, and what's present but weak.
3. **Judge fit, not just presence.** Flag over-engineering (a CRUD app with event sourcing and 4 message brokers) as a finding too — unnecessary complexity is a real cost.
4. **Output findings and recommendations** in the format below, prioritized by impact.

Be concrete: cite file paths, name the missing thing, and link the deeper guidance rather than re-explaining it. Keep each finding to 1–3 lines.

On medium-to-large projects (Tier 3+, or any repo too big to scan in one pass), fan the scan out across **parallel subagents** — e.g. one per bounded context / service / checklist area — then consolidate their findings into a single audit. Keep the classification step (step 1) centralized so every subagent audits against the same tier.

## Classification

First determine **scale/complexity tier**, then **structural style**. Use evidence: directory layout, service count, dependency manifests, deploy config, team signals (CODEOWNERS, number of contributors), and domain breadth.

**Tiers**

1. **Simple** — personal scripts, hobby projects, single responsibility, one developer.
2. **Medium** — a real web service: backend + frontend, persistent data, a handful of contributors, deployed somewhere.
3. **High** — multiple services or multiple bounded domains, several teams, inter-service communication.
4. **Enterprise** — commercialized / multi-tenant SaaS, with monetization, compliance, and scale concerns baked in.

**Structural style** (orthogonal to tier — name whichever fits): single script · monolith · modular monolith · onion/hexagonal/clean · microservices · event-driven · serverless · monorepo-of-services. Note mismatches (e.g. "microservices" that all share one database = distributed monolith).

When the tier is ambiguous, pick the lower one and note the boundary — most over-engineering comes from auditing up a tier.

## Checklists

Cumulative: include all lower tiers. Each bullet is a principle to verify; the link is where to go deeper.

### Tier 1 — Simple

- **README that orients in 30 seconds** — what it does, how to run it, key deps. [Make a README](https://www.makeareadme.com/)
- **AGENTS.md for AI agents** — build/test/convention notes so an agent (or new dev) can work the repo. [agents.md](https://agents.md/)
- **Reproducible setup** — pinned deps and a one-command install/run (`uv`, `package.json`, `Makefile`, etc.).
- **Single responsibility** — the script/module does one thing; no half-built abstractions waiting for a second use case. [YAGNI](https://martinfowler.com/bliki/Yagni.html)
- **Version control hygiene** — meaningful commits, a `.gitignore`, no secrets or build artifacts committed.

### Tier 2 — Medium (web service)

- **Layered/onion structure** — distinct domain/business-service layer isolated from transport (HTTP) and persistence (DB); dependencies point inward. [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- **Linting + formatting enforced** — config committed and run in CI, not just locally (e.g. ruff/eslint/prettier).
- **Test pyramid** — unit + integration + at least smoke-level e2e (browser or CLI); fast feedback over exhaustive slow tests. [Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)
- **Cursor-based pagination** — a `Page`/`Cursor` type carried through the domain and DB layers, not raw offset/limit leaking into handlers. [Cursor pagination](https://slack.engineering/evolving-api-pagination-at-slack/)
- **Versioned DB migrations** — schema changes are versioned, reviewed, and applied through a migration tool (Flyway/Alembic/etc.), not hand-run SQL; ideally reversible and forward-compatible. [Evolutionary Database Design](https://martinfowler.com/articles/evodb.html)
- **CONTEXT.md** — the ubiquitous language, domain model, and key entities written down so the model is shared. [Ubiquitous Language](https://martinfowler.com/bliki/UbiquitousLanguage.html)
- **ADRs** — architecture decisions recorded with context and consequences, in-repo under `docs/adr/`. [ADR GitHub org](https://adr.github.io/)
- **Minimal observability** — structured logging and a coherent error-handling strategy (no swallowed exceptions, consistent error responses).
- **AuthN/AuthZ defined** — every API surface is protected by default; authorization rules are explicit, not implicit-by-route. [OWASP Auth Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- **Config & secrets externalized** — environment-based config, secrets never in code. [12-Factor: Config](https://12factor.net/config)
- **CI pipeline** — push runs lint + tests + build; broken main is visible.

### Tier 3 — High (multiple services / domains)

Each item targets a **boundary**, independent of deployment topology. Items marked _(distributed)_ apply only when contexts are separate services; in a modular monolith, judge their in-process equivalent instead.

- **Repo organized by domain/bounded context** — each context has its own `CONTEXT.md`; a root `CONTEXT-MAP.md` shows how contexts relate. [Bounded Context](https://martinfowler.com/bliki/BoundedContext.html) · [Context Map](https://github.com/ddd-crew/context-mapping)
- **PRODUCT_BRIEF.md** — high-level business context and product requirements, so technical decisions trace to product intent.
- **Decompose by business capability / subdomain** — modules/services align to domains, not technical layers. [Decompose by subdomain](https://microservices.io/patterns/decomposition/decompose-by-subdomain.html)
- **Data ownership per context** — each context owns its data; no other context reads its tables directly. In services this is a database per service; in a modular monolith it's an enforced schema/module boundary, not just a convention. (Shared schema across services = distributed monolith.) [Database per Service](https://microservices.io/patterns/data/database-per-service.html)
- **Explicit inter-context communication** — how contexts talk is a deliberate, documented choice: a module API boundary in a monolith; sync (REST/gRPC) vs async (messaging) _(distributed)_ across services. [RPI](https://microservices.io/patterns/communication-style/rpi.html) · [Messaging](https://microservices.io/patterns/communication-style/messaging.html)
- **API contracts & versioning** — interfaces have a published schema (OpenAPI/protobuf/AsyncAPI), are versioned, and changes are guarded by consumer-driven contract tests so a producer can't silently break consumers. [Consumer-Driven Contracts](https://martinfowler.com/articles/consumerDrivenContracts.html) · [Pact](https://docs.pact.io/)
- **Data consistency across boundaries** — cross-context writes are handled deliberately: a local transaction in a monolith; Saga + Transactional Outbox _(distributed)_ once writes span services. [Saga](https://microservices.io/patterns/data/saga.html) · [Outbox](https://microservices.io/patterns/data/transactional-outbox.html)
- **Resilience at boundaries** _(distributed)_ — circuit breakers, timeouts, retries with backoff, idempotent consumers on calls that cross the network. [Circuit Breaker](https://microservices.io/patterns/reliability/circuit-breaker.html) · [Idempotent Consumer](https://microservices.io/patterns/communication-style/idempotent-consumer.html)
- **API gateway / BFF** _(distributed)_ — clients hit a unified edge, not individual services directly. [API Gateway](https://microservices.io/patterns/apigateway.html)
- **Webhooks done right (if exposed/consumed)** — signed payloads, replay/idempotency protection, retries with backoff, and a verification/debugging story for consumers. [webhooks.fyi](https://webhooks.fyi/)
- **High observability** — JSON structured logs, log aggregation, application metrics, and distributed tracing; ideally OpenTelemetry-native. [OpenTelemetry](https://opentelemetry.io/docs/) · [Distributed Tracing](https://microservices.io/patterns/observability/distributed-tracing.html)
- **Audit logging** — security/compliance-relevant actions recorded immutably, distinct from operational logs.
- **Health checks + deployment platform** — every deployable exposes health endpoints; deploys are containerized and automated. [Health Check API](https://microservices.io/patterns/observability/health-check-api.html)
- **Standards-based feature flags** — if flags exist, use an OpenFeature-compatible provider, not bespoke booleans. [OpenFeature](https://openfeature.dev/)
- **Service-to-service security** _(distributed)_ — propagate identity via signed access tokens; don't trust the network. [Access Token](https://microservices.io/patterns/security/access-token.html)
- **Tested backups & restore** — persistent data has automated backups and a restore that's actually been exercised, not just configured.
- **Supply-chain security** — dependencies and containers are scanned for known vulnerabilities (SCA), an SBOM is produced, and secret-scanning runs in CI; builds are reproducible/provenanced. [SLSA](https://slsa.dev/) · [OWASP Top 10](https://owasp.org/www-project-top-ten/)

### Tier 4 — Enterprise (commercialized SaaS)

- **Entitlements layer** — what a customer can access/do is modeled as data (entitlements), decoupled from billing and from feature flags. [Entitlements untangled (Stigg)](https://www.stigg.io/blog-posts/entitlements-untangled-the-modern-way-to-software-monetization)
- **Monetization baked in** — plans, metering/usage tracking, and billing integration (e.g. Stripe) as first-class concerns, not bolt-ons.
- **Multi-tenancy & isolation** — tenant boundary is explicit and enforced in data + auth; isolation model (pool vs silo) is a documented decision. [SaaS tenant isolation](https://docs.aws.amazon.com/whitepapers/latest/saas-architecture-fundamentals/tenant-isolation.html)
- **Compliance & data governance** — data residency, retention, PII handling, and audit trails mapped to the relevant regime (SOC 2 / GDPR / HIPAA as applicable).
- **SLOs & error budgets** — reliability targets defined and measured, with alerting tied to them, not to raw resource metrics. [Google SRE: SLOs](https://sre.google/sre-book/service-level-objectives/)
- **Cost observability (FinOps)** — per-tenant / per-service cost is attributable; unit economics are visible. [FinOps Framework](https://www.finops.org/framework/)
- **DR & data lifecycle** — tested backups, defined RTO/RPO, and a documented disaster-recovery runbook.
- **Secrets & key management** — centralized secrets manager and rotation; no long-lived static credentials.
- **Money-handling correctness (if it touches money)** — no invented/lost data: exact representation (minor units, not floats), double-entry ledgers, idempotent transfers, and reconciliation against external providers. [Fintech Engineering Handbook](https://w.pitula.me/fintech-engineering-handbook/)

## Output format

```markdown
# Architecture Audit — {project name}

## Classification

- **Tier:** {1–4} ({Simple|Medium|High|Enterprise}) — {one-line justification with evidence}
- **Structural style:** {style} — {what the code actually looks like; note any mismatch}
- **Scope audited:** {what you looked at; note anything excluded}

## Findings

Grouped by the checklist areas relevant to the tier. Mark each: ✅ solid · ⚠️ weak/partial · ❌ missing · 🔶 over-engineered.

### {Area, e.g. Structure & layering}
- ✅ {What's there and why it's good} — `path`
- ⚠️ {Present but weak; the specific gap} — `path`
- ❌ {Missing principle} — {one-line impact}

{repeat per area}

## Recommendations

Prioritized, most impact first. Each is actionable, not a restatement of the finding.

1. **{Do this}** — {why it matters at this tier, expected payoff}. {link to guidance}
2. ...

### Don't (yet)
{Things that would be over-engineering at this tier — explicitly call out what NOT to add, so the team doesn't gold-plate.}
```

## Notes

- The single most common failure is **tier mismatch in both directions**: enterprise ceremony on a hobby project, or a multi-team system held together by a Tier-1 setup. Always anchor findings to the detected tier.
- These checklists are a starting point, not gospel. If the project has a good reason to deviate (documented in an ADR), that's a ✅, not a ❌.
- If you can't determine something from static inspection (e.g. "is auth actually enforced"), say so rather than guessing — flag it as "needs verification."
