## Underpass AI

**The memory and execution layer for operational AI systems.**

We don't build models. We build the two planes that make them operationally useful: a memory plane that restores exactly the right context, and an execution plane that governs every action.

### What we build

**Memory plane** — The [Rehydration Kernel](https://github.com/underpass-ai/rehydration-kernel) holds a knowledge graph of decisions, incidents, and operational history. When an event fires, it delivers only what the agent needs for its role. Typed explanatory relationships preserve *why* each piece of context exists. Each resolved incident becomes legitimate context for the next — the kernel accumulates institutional knowledge the way a senior engineer accumulates experience.

**Execution plane** — The [Underpass Runtime](https://github.com/underpass-ai/underpass-runtime) provides isolated workspaces with 99 governed tools across 23 families. Every invocation is policy-checked, telemetry-recorded, and feeds a learning loop. A 4-tier recommendation engine (heuristic → Thompson Sampling → Neural Thompson Sampling) learns which tools work best for each context.

Together they form **infrastructure, not an application**. Any domain that needs institutional memory plus governed action can be built on top.

### How it works

Underpass is deployed alongside a client's existing infrastructure. The client's systems (observability, CI/CD, ERPs, operational platforms) produce **domain events** following an AsyncAPI contract. Underpass agents consume these events, investigate real systems, and act through governed workflows.

```
Client infrastructure produces domain event (alert, deviation, deadline)
  → Specialist agent investigates the real system (code, metrics, data)
    → Kernel provides historical context from past resolutions
      → Agent acts via governed runtime tools (patch, test, deploy, report)
        → Evidence recorded → Policies improve → Kernel enriched
          → Next similar event: faster, more confident resolution
```

Each agent is a specialist with a defined purpose, autonomy boundary, and success criteria. Local models (Qwen 9B) handle routine work. Frontier models (Claude) only appear where reasoning quality justifies cost.

### Use cases

Kernel + Runtime are **domain-agnostic**. Any workflow that requires agents acting on real systems with institutional memory and auditable execution:

**Software engineering**
- Production incident resolution — alert to deployment to recovery confirmation
- Security vulnerability remediation — CVE triage across services
- Codebase migration — framework upgrades with accumulated patterns
- Infrastructure drift detection and correction

**Beyond software**
- Supply chain disruption response — sourcing, logistics, negotiation
- Clinical trial protocol deviations — classification, CAPA, regulatory filing
- Financial regulatory reporting — extraction, reconciliation, submission
- Legal contract analysis — risk scoring, precedent search, redlining
- Manufacturing quality control — sensor correlation, containment, 8D reports
- Insurance claims processing — verification, fraud detection, adjudication
- Energy grid anomaly response — real-time load balancing, protection
- Talent acquisition optimization — bottleneck analysis, process intervention

The common pattern: **domain event triggers specialist agents → kernel provides institutional memory → runtime governs execution → each resolution enriches the next**.

### Architecture: what's ours, what's the client's

| Component | Ownership | Examples |
|-----------|-----------|---------|
| **Kernel + Runtime** | Underpass | Memory graph, governed tools, agent fleet |
| **AsyncAPI contract** | Underpass (spec) | Event schema the client must conform to |
| **Integration adapter** | Client (implementation) | Alert relay, CI/CD hooks, ERP connectors |
| **Application services** | Client | payments-api, order-svc, etc. |
| **Observability** | Client | Prometheus, Grafana, PagerDuty, Datadog |
| **CI/CD** | Client | GitHub Actions, Jenkins, ArgoCD |

### Repositories

| Plane | Repository | Language | What it provides |
|-------|-----------|----------|-----------------|
| **Execution** | [`underpass-runtime`](https://github.com/underpass-ai/underpass-runtime) | Go | 99 governed tools, K8s workspaces, NeuralTS recommendations, mTLS, 15 E2E tests |
| **Memory** | [`rehydration-kernel`](https://github.com/underpass-ai/rehydration-kernel) | Rust | Knowledge graph rehydration, explanatory relationships, 270 unit tests, 4 E2E Helm tests |
| **Demo** | [`underpass-demo`](https://github.com/underpass-ai/underpass-demo) | Go | Live incident resolution demo with real alerts, real services, real deployment |

### Production-grade infrastructure

- **Security**: TLS 1.3 on all transports, policy engine with RBAC, CodeQL + SonarCloud
- **Testing**: 80% coverage gates, 19 E2E tests via `helm test`, fail-fast, no fallbacks
- **CI/CD**: Automated image builds on merge, all images share Chart.appVersion
- **Observability**: Domain quality metrics, OTel tracing, structured logging

### The compound value thesis

The kernel's value grows with every resolved incident. The first resolution is slow — agents investigate from first principles. The tenth is fast and confident — the kernel has real context from nine previous investigations. **Switching away from Underpass means losing accumulated institutional knowledge.** This is the moat.

### Status

Core infrastructure deployed and validated on live Kubernetes clusters with full mTLS. The production incident demo runs end-to-end: real Grafana alert fires → agents investigate real code → agents deploy fix through real CI/CD → service recovers → alert resolves. Agent coordination and multi-domain support in active development.

### Ownership

Underpass AI is a project created by Tirso Garcia Ibanez.

Public repositories are released under Apache-2.0.
Where present, LICENSE and NOTICE files define redistribution and attribution requirements.

### Contact

Created by [Tirso Garcia Ibanez](https://github.com/tgarciai) · [LinkedIn](https://www.linkedin.com/in/tirsogarcia/)

- tgarciai@underpassai.com
- contact@underpassai.com
