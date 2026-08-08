# Evaluation Framework

Use this reference for comprehensive single-service reports and comparisons. It standardizes evidence collection without turning judgment into a mechanical score.

## Evidence labels

- **Confirmed:** Supported by a regulator, court, filing, technical evidence, or multiple reliable sources.
- **Vendor claim:** Asserted by the provider but not independently verified in the available evidence.
- **Inference:** A conclusion drawn from disclosed architecture or behavior; explain the premises.
- **Unknown:** Material information is absent, inaccessible, contradictory, or too stale.

Attach one of these labels in prose when the distinction would change the reader's decision.

## Research query set

Adapt names, former names, legal entities, app package IDs, and domains.

### Privacy and legal

- `{service} privacy policy EEA controller DPO`
- `{service} data retention delete account export data`
- `{service} international transfer SCC China United States`
- `site:edpb.europa.eu {service or entity}`
- `site:{relevant DPA domain} {service or entity}`
- `{service} GDPR fine complaint investigation decision`
- `{entity} annual report privacy cybersecurity`

### Incidents and security

- `{service} breach leak incident exposed data`
- `{service} vulnerability security research`
- `{service or package ID} CVE`
- `site:nvd.nist.gov {service or entity}`
- `site:github.com/advisories {service or package}`
- `{service} bug bounty security advisory end of life updates`

Use date filters and search each of the last five calendar years when results are noisy.

### Portability and APIs

- `{service} download your data export format`
- `{service} import data migration interoperability`
- `{service} developer API OAuth rate limit pricing`
- `site:{official developer domain} export webhook scopes`
- `{service} API partner application individual developer`
- `{service} Data Act connected product data access`

### Open source

- `site:github.com {service} api client export`
- `site:github.com {service} sync bridge connector`
- `site:github.com {package ID or API domain}`
- `site:github.com {service} reverse engineering`

Repeat searches with former brand names and distinctive endpoint domains.

## Portability posture

Judge the user-visible outcome:

- **Strong:** Timely self-service export in documented machine-readable formats; broad raw and derived data; repeatable access or a usable personal API; practical import or migration paths.
- **Mixed:** Self-service archive or useful integrations exist, but automation, formats, completeness, or imports are limited.
- **Weak:** Support-mediated or GDPR-request-only export; opaque archive; no meaningful import; lock-in remains high.
- **Unknown:** The export cannot be verified from public documentation.

Do not count screenshots, PDFs, emailed summaries, or dashboards as machine-readable portability.

## Hobbyist API accessibility

Classify the official interface:

1. **Open:** Individual self-service registration, public current docs, user OAuth, useful free allowance, and no sales approval.
2. **Accessible with friction:** Individual registration exists but requires review, payment, limited scopes, or substantial setup.
3. **Partner-only:** Company, research institution, commercial agreement, or manual approval required.
4. **Device-local only:** Public SDK reads sensors or local state but cannot access full cloud history.
5. **No supported API:** Only manual export, platform sync, or private endpoints exist.

State multiple classifications when the service exposes different cloud, device, and enterprise APIs.

## Open-source project triage

Inspect the repository rather than relying on its description. Record:

- canonical URL and whether it belongs to the vendor;
- license and install/distribution channel;
- last meaningful commit and release, not merely automated dependency updates;
- number and recency of maintainers responding to issues or pull requests;
- authentication flow and secret storage;
- network endpoints and use of undocumented APIs;
- tests, CI, release signing, dependency maintenance, and security policy;
- reports of account bans, broken authentication, regional incompatibility, or data corruption.

Use these risk labels:

- **Low:** Official API, OAuth, least-privilege scopes, maintained code, clear license.
- **Moderate:** Private endpoints or local database access, but transparent implementation and no credential interception.
- **High:** Password collection, copied session tokens, rooted-device extraction, TLS interception, disabled certificate checks, bundled opaque binaries, or abandoned authentication code.

Explain that unofficial does not automatically mean malicious; the risk comes from authentication, stability, maintenance, and contractual exposure.

## Comparison discipline

For comparisons, hold region and product category constant. Do not compare a fitness app's health-data policy with a phone manufacturer's generic website policy. Use the same research date and evidence window for every service.

Compare at least:

- controller and enforceability;
- storage and overseas access;
- special-category data and advertising use;
- retention and deletion;
- confirmed incident history;
- update/support lifetime for connected products;
- export quality;
- API accessibility;
- open-source escape hatches.

Prefer a compact table followed by decisive caveats. Avoid declaring a universal winner when the answer changes by threat model.

## Completeness check

Before delivery, verify that the report:

- names the exact service and research date;
- identifies the relevant controller rather than only headquarters;
- separates EU storage from global access;
- dates policies, incidents, and developer documentation;
- distinguishes a manual archive from an API;
- reports read and write capabilities separately;
- checks individual eligibility and pricing, not merely the existence of developer docs;
- includes maintained open-source options and explicit authentication risks;
- says what could not be verified;
- leads with a decision useful to the user.
