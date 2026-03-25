## Underpass AI

**We don't build models. We engineer the infrastructure that makes them useful.**

We focus on surgical context, governed execution, and statistical tool selection. Our benchmark data shows that structured explanatory context narrows the accuracy gap between local and frontier models — an 8B model with well-structured context scores comparably to frontier models on task identification, restart-point selection, and rationale preservation in synthetic evaluation graphs.

We use Claude, OpenAI, Qwen, or whatever model fits the job. We're not competing with model providers — we're building the engineering layer that helps extract more value from any model.

### What we build

**Context rehydration** — A knowledge graph holds the full picture. When an event fires, the Rehydration Kernel traverses only what matters for that agent's role, renders token-counted sections, and delivers a bounded bundle. Typed explanatory relationships preserve why each node exists — rationale, motivation, method, and decision linkage — so agents can diagnose failures, resume interrupted work, and justify decisions from rehydrated context alone. Fewer tokens, better signal.

**Governed tool execution** — Agents don't run loose. The Underpass Runtime provides isolated workspaces with 96+ tools under policy enforcement. Every invocation is tracked, audited, and produces telemetry that feeds back into the system.

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

| Layer | Repository | What it does |
|-------|-----------|-------------|
| **Product** | [`swe-ai-fleet`](https://github.com/underpass-ai/swe-ai-fleet) | Multi-agent SWE platform — planning, deliberation, and execution |
| **Execution** | [`underpass-runtime`](https://github.com/underpass-ai/underpass-runtime) | Isolated workspaces, 96+ governed tools, telemetry, tool-learning pipeline |
| **Context** | [`rehydration-kernel`](https://github.com/underpass-ai/rehydration-kernel) | Graph-native context rehydration with explanatory relationships — bounded retrieval across pull and event-driven runtimes |

As the platform matures, we extract focused modules from the runtime and kernel — each independently deployable, each solving one problem well.

### Demos

| Repository | What it shows |
|-----------|--------------|
| [`underpass-demo`](https://github.com/underpass-ai/underpass-demo) | Runtime + tool-learning in action (Thompson Sampling, cost benchmarks) |
| [`rehydration-starship-demo`](https://github.com/underpass-ai/rehydration-starship-demo) | Context rehydration + event-driven agents + model routing |

### Open source

Apache 2.0. We build in the open because this kind of infrastructure should be shared, challenged, and improved by the community. Fork it, break it, make it better.

### Status

We're in the experimental phase — actively building toward production-ready products. The core services are deployed and the end-to-end demos work. Benchmark results on synthetic graphs are documented in the kernel repo. What's ahead is hardening, broader evaluation, and real-world adoption. Early adopters and contributors welcome.

### People

Created by [Tirso Garcia](https://github.com/tgarciai) · [LinkedIn](https://www.linkedin.com/in/tirsogarcia/)

### Contact

- tgarciai@underpassai.com
- contact@underpassai.com
