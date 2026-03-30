## Underpass AI

**We don't build models. We engineer the infrastructure that makes them useful.**

We focus on surgical context, governed execution, and statistical tool selection. Our benchmark data shows that structured explanatory context narrows the accuracy gap between local and frontier models — an 8B model with well-structured context scores comparably to frontier models on task identification, restart-point selection, and rationale preservation in synthetic evaluation graphs.

We use Claude, OpenAI, Qwen, or whatever model fits the job. We're not competing with model providers — we're building the engineering layer that helps extract more value from any model.

### What we build

**Context rehydration** — A knowledge graph holds the full picture. When an event fires, the Rehydration Kernel traverses only what matters for that agent's role, renders token-counted sections, and delivers a bounded bundle. Typed explanatory relationships preserve why each node exists — rationale, motivation, method, and decision linkage — so agents can diagnose failures, resume interrupted work, and justify decisions from rehydrated context alone. Fewer tokens, better signal.

**Governed tool execution** — Agents don't run loose. The Underpass Runtime provides isolated workspaces with 99 governed tools across 23 families — filesystem, git, build, test, security, containers, Kubernetes, messaging, data — all under policy enforcement with full telemetry. Every invocation is tracked, audited, and produces telemetry that feeds the learning loop. OpenAPI 3.1 and AsyncAPI 3.0 contracts define the API surface.

**Statistical tool selection** — No LLM call needed to pick the right tool. Thompson Sampling ranks tools by empirical success rate per context, with hard SLO constraints on latency, error rate, and cost. The telemetry loop closes itself — tools that fail get ranked down, tools that work get ranked up.

### Event-driven agents

When something happens, the right agent fires. No polling. No central orchestrator.

```
NATS event → specific agent activates → kernel delivers surgical context →
  Thompson Sampling selects best tools → runtime executes governed →
    telemetry feeds back → policies improve → next event, better decisions
```

Each agent is a specialist: one for diagnostics, another for repairs, another for strategic decisions. Local models handle routine work on GPU. When a task requires stronger reasoning, the system can escalate to frontier APIs — with bounded context, not sprawling prompts.

### Model-agnostic

The platform doesn't care what reasons. Claude, OpenAI, open-weight models via vLLM — swap the model, keep the infrastructure. The value is in context quality and execution governance, not in any specific model.

### Repositories

| Layer | Repository | Language | What it does |
|-------|-----------|----------|-------------|
| **Product** | [`swe-ai-fleet`](https://github.com/underpass-ai/swe-ai-fleet) | Python | Multi-agent SWE platform — planning, deliberation, and execution |
| **Execution** | [`underpass-runtime`](https://github.com/underpass-ai/underpass-runtime) | Go | 99 governed tools, isolated workspaces, TLS across 5 transports, Thompson Sampling pipeline, Helm chart with mTLS |
| **Context** | [`rehydration-kernel`](https://github.com/underpass-ai/rehydration-kernel) | Rust | Graph-native context rehydration with explanatory relationships — 270 unit tests, 9 integration tests, LLM-as-judge benchmark (432 evaluations) |

### Production-grade infrastructure

Both core services have been through comprehensive quality audits:

- **Security**: Threat models, trust boundary diagrams, TLS 1.3 on all transports, policy engine with RBAC, audit logging with secret redaction, CodeQL + govulncheck + SonarCloud in CI
- **Operations**: Helm charts with dev/production/mTLS value overrides, HPA, PDB, NetworkPolicy, PrometheusRule with 6 alerts, operational runbooks
- **Testing**: 80% coverage gates, 14 E2E tests as K8s Jobs (smoke/core/full tiers), table-driven unit tests with hand-written fakes
- **API contracts**: OpenAPI 3.1 (HTTP), AsyncAPI 3.0 (NATS events), contract validation in CI
- **Observability**: Domain-layer quality metrics as value objects, Prometheus exposition, OTel tracing, structured logging
- **CI/CD**: Automated dependency updates (Dependabot), release automation (tag-triggered builds + GHCR push), quality gate scripts

### Demos

| Repository | What it shows |
|-----------|--------------|
| [`underpass-demo`](https://github.com/underpass-ai/underpass-demo) | Runtime + tool-learning in action (Thompson Sampling, cost benchmarks) |
| [`rehydration-starship-demo`](https://github.com/underpass-ai/rehydration-starship-demo) | Context rehydration + event-driven agents + model routing |

### Architecture decisions

Both services maintain Architecture Decision Records (ADRs) documenting key design choices with explicit trade-offs and alternatives considered. Security models with threat analysis are published in each repository.

### Open source

Apache 2.0. We build in the open because this kind of infrastructure should be shared, challenged, and improved by the community. Fork it, break it, make it better.

### Status

The core services are deployed and validated through end-to-end tests on live Kubernetes clusters with full TLS. Benchmark results on synthetic graphs are documented in the kernel repo. We're actively hardening for production adoption. Early adopters and contributors welcome.

### People

Created by [Tirso Garcia](https://github.com/tgarciai) · [LinkedIn](https://www.linkedin.com/in/tirsogarcia/)

### Contact

- tgarciai@underpassai.com
- contact@underpassai.com
