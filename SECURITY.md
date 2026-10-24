# Security policy

This policy covers every public Underpass AI repository that does not publish
its own `SECURITY.md`. KMP and MADE publish their own; follow those for them.

## Reporting a vulnerability

Do not open a public issue for an undisclosed vulnerability.

Use GitHub private vulnerability reporting on the affected repository: its
**Security** tab, **Report a vulnerability**
(`https://github.com/underpass-ai/<repository>/security/advisories/new`).
If that form is unavailable, contact a maintainer through GitHub without
publishing exploit details.

Please include:

- the affected repository and release or commit
- a minimal, redacted reproduction
- the impact
- any known mitigation

Do not publish credentials or an exploit before coordinated triage.

## Supported versions

The projects are pre-1.0. Fixes land on `main` and ship in the next release
where a repository publishes releases; only the latest release is supported.
Response is best-effort, and an advisory names the affected and fixed
versions.
