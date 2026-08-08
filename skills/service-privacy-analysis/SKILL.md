---
name: service-privacy-analysis
description: Research the privacy, data protection, security history, portability, interoperability, and developer ecosystem of an online service, app, connected device, or cloud platform. Use when the user asks for a privacy analysis or due-diligence report for a named service; its GDPR or EEA posture; data residency and international transfers; breaches, vulnerabilities, or regulatory incidents; export, deletion, and import mechanisms; public APIs accessible to hobby developers; third-party integrations; or complementary open-source and reverse-engineered tools.
---

# Service Privacy Analysis

Assess a named service from the perspective of an informed EU/EEA customer and hobby developer. Determine what is legally promised, what is technically exposed, what has gone wrong, and how easily users can move or program against their data.

## Core rules

- Browse for current evidence. Policies, controllers, incidents, APIs, prices, and product capabilities change frequently.
- Analyze the exact product and region, not merely the parent company's homepage. Separate the website, mobile app, device, account system, cloud, AI features, and optional integrations when their terms differ.
- Distinguish **vendor claim**, **independently verified fact**, **reasonable inference**, and **unknown**. Never turn a compliance claim or app-store disclosure into proof of implementation.
- Distinguish data location from data access. An EU server does not establish EU-only processing, manufacturer-blind encryption, or freedom from overseas access.
- Prefer direct links and cite each material claim near the claim. Give policy dates and incident dates.
- Treat the result as practical research, not legal advice. State uncertainty instead of guessing.
- Do not sign up, accept terms, submit privacy requests, extract tokens, intercept traffic, or run unofficial code unless the user separately requests and authorizes that action.

For comprehensive reports or comparisons, read [references/evaluation-framework.md](references/evaluation-framework.md) before researching.

## Workflow

### 1. Fix the scope

Identify the service, product surface, user type, and jurisdiction. Unless the user specifies otherwise, assume an adult consumer residing in the EEA using the current public version.

Resolve naming and ownership first: current brand, former names, parent company, app publisher, relevant subsidiaries, acquisitions, and the entity actually providing the service. Do not infer the controller from headquarters or incorporation alone.

### 2. Map the entities and data flow

Find product-specific notices and establish:

- controller, joint controllers, processors, EU representative, and DPO;
- account and app provider, hosting regions, and disclosed subprocessors;
- categories of collected, inferred, uploaded, and third-party data;
- special-category data such as health, biometrics, sexuality, or precise location;
- which features are local, cloud-dependent, optional, or enabled by default;
- international storage, remote access, backup, and onward-transfer arrangements.

Where public documents conflict, present both statements and explain the most plausible boundary without pretending the conflict is resolved.

### 3. Evaluate the EU privacy posture

Check the current privacy policy, product-specific notices, consent screens where documented, terms, cookie/advertising disclosures, and privacy portal. Cover:

- purposes and asserted legal bases;
- consent and withdrawal controls;
- minimization and default settings;
- retention periods and backup/legal exceptions;
- access, correction, objection, restriction, portability, and erasure;
- profiling, advertising, research, AI training, and automated decisions;
- children's treatment where relevant;
- transfers outside the EEA, adequacy decisions, SCCs, binding corporate rules, transfer-impact assessments, and supplementary measures;
- certifications and their exact entity, system, scope, issuer, and validity;
- public regulator decisions, complaints, investigations, fines, or court cases.

Do not equate GDPR applicability with demonstrated compliance. Do not equate SCCs with physical data localization.

### 4. Research security and incident history

Search at least the last five years, plus older unresolved events, across official security advisories, regulator databases, breach notifications, company filings, CVE databases, independent research, and reputable reporting.

For each relevant event, record the event date, discovery or disclosure date, affected product and population, exposed data, cause, company response, remediation, regulator outcome, and present relevance. Separate:

- confirmed breach or misuse;
- vulnerability with no demonstrated exploitation;
- service outage or data loss;
- third-party or credential-stuffing incident;
- allegation not established by reliable evidence.

If no material incident is found, say what sources and time range were searched. Never state that no incident occurred merely because none was found publicly.

Also inspect the vulnerability-reporting channel, bug bounty, encryption claims, authentication options, security-update policy, device end-of-life list, and transparency reports. A certification supports process maturity; it does not prove the absence of exploitable flaws.

### 5. Test portability and interoperability on paper

Find the actual user path for export, deletion, and import. Report:

- whether it is self-service, support-mediated, or only a formal data-subject request;
- available formats, schema/documentation, date range, raw versus derived data, metadata, attachments, and completeness;
- expected delay, rate or frequency limits, and whether repeated/automatic export is possible;
- whether deletion covers the account, individual records, backups, social copies, and connected services;
- supported imports, migrations, platform bridges, and standards;
- relevant GDPR portability and EU Data Act mechanisms without overstating what either law guarantees.

Treat a downloadable archive as different from an API, and an API as different from practical interoperability.

### 6. Audit hobby-developer access

Find the official developer portal and documentation, then determine:

- whether an individual can register without a company, partnership, sales call, or approval;
- whether access is free, paid, usage-metered, or unpublished;
- whether the API is public, partner-only, private, deprecated, or apparently abandoned;
- OAuth and consent model, scopes, read/write coverage, raw and derived data, history depth, webhooks, bulk export, rate limits, SDKs, sandbox, and data-use restrictions;
- documentation freshness, changelog, uptime/status information, and support channel;
- whether the terms permit personal projects, storage, analytics, and redistribution.

When registration is required, inspect public documentation without creating an account. Label inaccessible details as unknown.

### 7. Survey open-source and reverse-engineering work

Search GitHub and other primary project homes using the service name, former names, app package IDs, domains, and terms such as `api`, `export`, `sync`, `client`, `oauth`, `scraper`, `connector`, `bridge`, and `reverse engineering`.

For promising projects, report:

- purpose and supported data;
- official API versus private endpoint, local database, device protocol, browser automation, or traffic capture;
- license, latest release or meaningful commit, maintainer activity, issue health, and supported regions;
- authentication method and whether it asks for passwords, session cookies, API tokens, rooted devices, or TLS interception;
- stability, lockout, privacy, security, and terms-of-service risks.

Do not recommend a project based on stars alone. Prefer maintained, licensed tools with transparent authentication and tests. Mark token extraction, credential collection, undocumented endpoints, and disabled TLS verification as high-risk. Do not execute a repository merely to evaluate it; inspect it statically unless the user asks for hands-on testing.

### 8. Synthesize a decision

Lead with a short verdict tailored to the user. Separate:

- privacy against the provider and its affiliates;
- security against outsiders;
- legal enforceability for an EEA user;
- portability and exit quality;
- hobbyist developer openness.

Use `strong`, `mixed`, `weak`, or `unknown` rather than false-precision scores unless the user requests a scoring model. Explain the decisive evidence and the most important unknowns. Give practical mitigations, questions to send the provider, and better-supported alternatives only when useful.

## Source strategy

Use this order of preference:

1. Current product-specific policies, developer documentation, security advisories, status pages, support manuals, and corporate/regulatory filings.
2. EU and national regulators, court decisions, ENISA, official breach notices, CVE records, and data-protection authorities.
3. Independent security research, academic papers, and reputable technical or investigative reporting.
4. Official app-store disclosures and certification registries.
5. GitHub repositories and their code, releases, issues, and commit history.
6. Community reports only as leads or evidence of user experience, never as sole proof of a legal or security claim.

Search in the service's home-market language when English results are incomplete. Prefer primary sources for technical claims. Note when a source is stale, generic, self-reported, geographically mismatched, or scoped to a different product.

## Default output

Use the smallest structure that answers the question. A full analysis should normally contain:

1. **Verdict** — concise consumer and tinkerer recommendation.
2. **Who controls the data** — entities, regions, and a simple data-flow explanation.
3. **Privacy and GDPR posture** — strengths, weaknesses, transfers, retention, and rights.
4. **Security and incidents** — dated, severity-calibrated history and current update posture.
5. **Export, deletion, and interoperability** — exact mechanisms and limitations.
6. **Developer access** — public/partner/private status, cost, capabilities, and friction.
7. **Open-source ecosystem** — maintained options with explicit risk notes.
8. **Practical conclusion** — mitigations, unresolved questions, and who should avoid the service.

Keep citations adjacent to claims. Avoid a detached bibliography unless the user requests one.
