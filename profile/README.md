## Underpass AI

**The memory and execution layer for operational AI systems.**

We don't build models. We build the two planes that make them operationally useful: a memory plane that restores exactly the right context, and an execution plane that governs every action.

### What we build

**Memory plane** — The [Rehydration Kernel](https://github.com/underpass-ai/rehydration-kernel) holds a knowledge graph of incidents, decisions, runbooks, and code history. When an event fires, it delivers only what the agent needs for its role. Typed explanatory relationships preserve *why* each piece of context exists.

**Execution plane** — The [Underpass Runtime](https://github.com/underpass-ai/underpass-runtime) provides isolated workspaces with 99 governed tools. Every invocation is policy-checked, telemetry-recorded, and feeds a learning loop. A 4-tier recommendation engine (heuristic → Thompson Sampling → Neural Thompson Sampling) learns which tools work best for each context.

Together they support any operational workflow that needs exact memory plus governed action: incident recovery, deploy verification, config remediation, runbook execution, infrastructure stabilization.

### Event-driven, not prompt-driven

When something happens, the right agent fires. No polling. No central orchestrator.

```
Alert fires → diagnostic agent classifies → kernel restores surgical context →
  repair agent executes governed tools → verification agent validates →
    evidence recorded → policies improve → next event, better decisions
```

Each agent is a specialist. Local models handle routine work. When a task requires stronger reasoning, the system escalates to frontier APIs — with bounded context, not sprawling prompts.

### Repositories

| Plane | Repository | Language | What it provides |
|-------|-----------|----------|-----------------|
| **Execution** | [`underpass-runtime`](https://github.com/underpass-ai/underpass-runtime) | Go | 99 governed tools, K8s workspaces, NeuralTS recommendations, mTLS, 15 E2E tests |
| **Memory** | [`rehydration-kernel`](https://github.com/underpass-ai/rehydration-kernel) | Rust | Knowledge graph rehydration, explanatory relationships, 270 unit tests, 4 E2E Helm tests |
| **Platform** | [`swe-ai-fleet`](https://github.com/underpass-ai/swe-ai-fleet) | — | Agent coordination, incident packs, operational workflows |

### Production-grade infrastructure

- **Security**: TLS 1.3 on all transports, policy engine with RBAC, CodeQL + SonarCloud
- **Testing**: 80% coverage gates, 19 E2E tests via `helm test`, fail-fast, no fallbacks
- **CI/CD**: Automated image builds on merge, all images share Chart.appVersion
- **Observability**: Domain quality metrics, OTel tracing, structured logging

### Laboratory

New capabilities — algorithms, agent architectures, incident packs — are designed, prototyped, and validated internally before shipping to the public repositories. If you're interested in early access or collaboration, reach out.

### Status

The core infrastructure is deployed and validated on live Kubernetes clusters with full mTLS. The incident demo runs end-to-end: alert → rehydrate → patch → test → validate. Agent coordination protocols and multi-workflow support are in active development.

### Ownership

Underpass AI is a project created by Tirso García Ibáñez.

Public repositories are released under Apache-2.0.
Where present, LICENSE and NOTICE files define redistribution and attribution requirements.

### Contact

Created by [Tirso García Ibáñez](https://github.com/tgarciai) · [LinkedIn](https://www.linkedin.com/in/tirsogarcia/)

- tgarciai@underpassai.com
- contact@underpassai.com
