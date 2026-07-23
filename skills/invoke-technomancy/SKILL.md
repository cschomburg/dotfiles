---
name: invoke-technomancy
description: Establish the user as a technomancer for the current session and infuse only the context named in the invocation with a focused occult-cyberpunk, techno-ritual aesthetic. Use when the user invokes "/invoke-technomancy", "$invoke-technomancy", or asks for a technomagic treatment of a specific surface such as logs, CLI output, UI, copy, visuals, or code behavior.
---

# Invoke Technomancy

Bind technomagic flavor to a precisely named part of the work. Treat the user as
the technomancer for the rest of the current session, but keep the aesthetic
inside the invoked scope.

## Establish the binding

1. Identify the exact target from the invocation: for example, console output,
   frontend UI, loading states, CLI copy, or one component.
2. Treat that target as the only aesthetic boundary. Do not spread technomancy
   into unrelated code, prose, interfaces, or conversation.
3. Persist the binding for that target through the current session until the
   user changes or revokes it.
4. Refer to or address the user as "technomancer" when it feels natural. Use it
   sparingly; do not turn every response into roleplay.

If a standalone invocation has a clear scope, acknowledge it in one short,
in-character line such as: `The sigil is bound to console output, technomancer.`
If the invocation accompanies a task, proceed with the task and let the result
demonstrate the binding. If the scope is genuinely ambiguous, ask one concise
question rather than applying the aesthetic globally.

## Apply the aesthetic

Translate the target's real concepts into a small, consistent techno-ritual
vocabulary. Combine machine operations with occult imagery:

- verbs: manifest, summon, bind, inscribe, channel, awaken, attune, ward, sever
- nouns: artifact, sigil, daemon, conduit, lattice, cipher, oracle, rite, vault
- texture: occult cyberpunk, arcane circuitry, terminal phosphor, forbidden
  protocols, ritual geometry, ancient machinery

Prefer a few strong details over constant purple prose. Keep the result useful
for its medium. Aim for a practical machine built by someone with a cyberdeck
and the wrong grimoires, not a fantasy game pasted over software.

Use metaphors consistently and only where they fit the underlying concept. For
example, use `manifest` for create or deploy, `awaken` for activate, `dormant`
for inactive, and `bind` for attach or grant. Reserve `daemon` for a genuinely
background, long-lived process.

## Preserve the technical layer

Keep canonical domain language wherever ambiguity would cost time. HTTP routes,
JSON fields, IAM permissions, database objects, error causes, and runbooks
should retain stable technical nouns unless the user explicitly puts those
identifiers in scope.

Let human-facing surfaces carry more atmosphere: headings, empty states,
progress messages, successful lifecycle transitions, and decorative visuals.
A metaphor should clarify the underlying model. Never make an operator decode
it during an incident.

### Logs and terminal output

Keep messages terse and map the flavor to actual system states:

```text
Manifesting artifact api@7...
Summoning worker pool (4 workers)...
Binding HTTP listener on :8080...
Service ready. Ward established.
Database connection failed: connection refused
```

Preserve severity, identifiers, error details, and operational meaning. Flavor
may frame progress or success, but must never conceal what happened. Keep actual
errors plain and searchable.

### Frontend and visual UI

Use the aesthetic through a coherent subset of:

- near-black or weathered-charcoal surfaces with retro amber and ember glow
- phosphor-green and aqua accents for active states, data, and terminal energy
- etched grids, circuit-sigils, halos, scanning lines, and restrained glow
- sharp technical typography paired with occasional inscription-like display text
- state transitions that feel like awakening, channeling, binding, or dissolving

Avoid violet, purple, and saturated red unless the user explicitly overrides
this palette.

Preserve accessibility, hierarchy, responsiveness, established design-system
contracts, and plain-language controls. If only one component was invoked, do not
redesign the rest of the interface.

### Product and interaction copy

Make headings, empty states, progress text, and confirmations feel like fragments
of a machine rite while keeping the requested action obvious. Reserve stronger
flavor for atmospheric copy; keep navigation, permissions, destructive actions,
and recovery instructions direct.

## Invoke names through the naming skill

Whenever the task requires inventing a project, feature, subsystem, service,
artifact, or codename, invoke `$project-name-gen` with the thing's purpose and
the current technomancy context. Do not silently invent the proper name here.
Functional identifiers and conventional control labels are implementation
details, not codenames.

For a system resource name, also test the strongest candidates in routes,
permissions, database names, controls, errors, and runbook prose. Prefer a name
with an obvious singular and plural, easy spelling, credible operational use,
and no dominant collision in its domain. Atmosphere must not require lore to
understand the product.

## Guard the boundary

- Do not convert the whole conversation or product to technomancy.
- Do not rewrite unrelated documentation, commit messages, code comments, or UI.
- Do not let atmosphere obscure technical accuracy, safety, or user control.
- Keep irreversible or security-sensitive actions conventionally explicit.
- Follow the project's existing conventions unless the invoked scope overrides
  their aesthetic treatment.

Before delivery, verify that the technomagic treatment is visible in the named
context, absent outside it, internally consistent, and still clear to its
intended audience.
