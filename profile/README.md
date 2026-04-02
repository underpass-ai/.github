## Underpass AI

**We don't build models. We engineer the infrastructure that makes them useful.**

We focus on surgical context, governed execution, and adaptive tool selection. Our benchmark data shows that structured explanatory context narrows the accuracy gap between local and frontier models — an 8B model with well-structured context scores comparably to frontier models on task identification, restart-point selection, and rationale preservation.

We use Claude, OpenAI, Qwen, or whatever model fits the job. We're not competing with model providers — we're building the engineering layer that extracts more value from any model.

### What we build

**Context rehydration** — A knowledge graph holds the full picture. When an event fires, the Rehydration Kernel traverses only what matters for that agent's role, renders token-counted sections, and delivers a bounded bundle. Typed explanatory relationships preserve why each node exists — rationale, motivation, method, and decision linkage — so agents can diagnose failures, resume interrupted work, and justify decisions from rehydrated context alone.

**Governed tool execution** — Agents don't run loose. The Underpass Runtime provides isolated workspaces with 99 governed tools across 23 families — filesystem, git, build, test, security, containers, Kubernetes, messaging, data — all under policy enforcement with full telemetry.

**Adaptive tool selection** — No LLM call needed to pick the right tool. A 4-tier algorithm stack (heuristic, telemetry, Thompson Sampling, Neural Thompson Sampling) ranks tools by empirical success rate per context, with hard SLO constraints on latency, error rate, and cost. The telemetry loop closes itself — tools that fail get ranked down, tools that work get ranked up.

### Event-driven agents

When something happens, the right agent fires. No polling. No central orchestrator.

```
NATS event → agent activates → kernel delivers surgical context →
  adaptive scorer selects tools → runtime executes governed →
    telemetry feeds back → policies improve → next event, better decisions
```

Each agent is a specialist. Local models handle routine work. When a task requires stronger reasoning, the system escalates to frontier APIs — with bounded context, not sprawling prompts.

### Repositories

| Layer | Repository | Language | What it does |
|-------|-----------|----------|-------------|
| **Execution** | [`underpass-runtime`](https://github.com/underpass-ai/underpass-runtime) | Go | 99 governed tools, isolated workspaces, 4-tier adaptive recommendations, NeuralTS, mTLS, Helm chart, 15 E2E tests |
| **Context** | [`rehydration-kernel`](https://github.com/underpass-ai/rehydration-kernel) | Rust | Graph-native context rehydration with explanatory relationships — 270 unit tests, 9 integration tests, LLM-as-judge benchmark (432 evaluations) |

### Production-grade infrastructure

Both core services have been through comprehensive quality audits:

- **Security**: Threat models, trust boundary diagrams, TLS 1.3 on all transports, policy engine with RBAC, audit logging, CodeQL + govulncheck + SonarCloud in CI
- **Operations**: Helm charts with dev/production/mTLS value overrides, HPA, PDB, NetworkPolicy, PrometheusRule, operational runbooks
- **Testing**: 80% coverage gates, 15 E2E tests as K8s Jobs via `helm test`, table-driven unit tests with hand-written fakes
- **API contracts**: gRPC (proto), OpenAPI 3.1, AsyncAPI 3.0, contract validation in CI
- **CI/CD**: Automated image builds on merge (runtime, e2e-runner, cert-gen, tool-learning), tag-triggered releases, GHCR push, quality gates

### Laboratory

New capabilities — algorithms, agent architectures, ceremony protocols — are designed, prototyped, and validated internally before shipping to the public repositories. If you're interested in early access or collaboration, reach out.

### Demos

| Repository | What it shows |
|-----------|--------------|
| [`underpass-demo`](https://github.com/underpass-ai/underpass-demo) | Runtime + tool-learning in action |

### Status

The core services are deployed and validated through end-to-end tests on live Kubernetes clusters with full mTLS. The adaptive recommendation engine runs a closed learning loop: telemetry feeds Thompson Sampling and Neural Thompson Sampling scorers in production.

### Ownership

Underpass AI is a project created by Tirso García Ibáñez.

Public repositories are released under Apache-2.0.
Where present, LICENSE and NOTICE files define redistribution and attribution requirements.

### Contact

Created by [Tirso García Ibáñez](https://github.com/tgarciai) · [LinkedIn](https://www.linkedin.com/in/tirsogarcia/)

- tgarciai@underpassai.com
- contact@underpassai.com
