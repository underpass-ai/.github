## Underpass AI

**We don't build models. We engineer the infrastructure that makes them actually work.**

While the industry races toward 128K context windows and ever-larger models, we go the opposite direction: surgical context, governed execution, and statistical tool selection. A 7B model with 394 tokens of the right context outperforms a frontier model drowning in 6,000 tokens of noise.

We use Claude, OpenAI, Qwen, or whatever model fits the job. We're not competing with the giants — we're building the engineering layer that squeezes every drop of value out of them.

### What we build

**Context rehydration** — A knowledge graph holds the full picture. When an event fires, the Rehydration Kernel traverses only what matters for that agent's role, renders token-counted sections, and delivers a surgical bundle. 98% context reduction. Fewer tokens, better reasoning.

**Governed tool execution** — Agents don't run loose. The Underpass Runtime provides isolated workspaces with 96+ tools under policy enforcement. Every invocation is tracked, audited, and produces telemetry that feeds back into the system.

**Statistical tool selection** — No LLM call needed to pick the right tool. Thompson Sampling ranks tools by empirical success rate per context, with hard SLO constraints on latency, error rate, and cost. The telemetry loop closes itself — tools that fail get ranked down, tools that work get ranked up.

### Event-driven agents

When something happens, the right agent fires. No polling. No central orchestrator.

```
NATS event → specific agent activates → kernel delivers surgical context →
  Thompson Sampling selects best tools → runtime executes governed →
    telemetry feeds back → policies improve → next event, better decisions
```

Each agent is a specialist: one for diagnostics, another for repairs, another for strategic decisions. Small models handle 95% of the work on local GPU at zero cost. When a task exceeds their capability, the system escalates to Claude or GPT — one strategic call at $0.006 with 394 surgical tokens, not $0.09 with 6,000.

### Model-agnostic

The platform doesn't care what reasons. Claude, OpenAI, open-weight models via vLLM — swap the model, keep the infrastructure. The value isn't in the model. It's in the engineering around it.

### Repositories

| Layer | Repository | What it does |
|-------|-----------|-------------|
| **Product** | [`swe-ai-fleet`](https://github.com/underpass-ai/swe-ai-fleet) | Multi-agent SWE platform — planning, deliberation, and execution |
| **Execution** | [`underpass-runtime`](https://github.com/underpass-ai/underpass-runtime) | Isolated workspaces, 96+ governed tools, telemetry, tool-learning pipeline |
| **Context** | [`rehydration-kernel`](https://github.com/underpass-ai/rehydration-kernel) | Deterministic context materialization from knowledge graphs |

As the platform matures, we extract focused modules from the runtime and kernel — each independently deployable, each solving one problem well.

### Demos

| Repository | What it shows |
|-----------|--------------|
| [`underpass-demo`](https://github.com/underpass-ai/underpass-demo) | Runtime + tool-learning in action (Thompson Sampling, cost benchmarks) |
| [`rehydration-starship-demo`](https://github.com/underpass-ai/rehydration-starship-demo) | Context rehydration + event-driven agents + model routing |

### Open source

Apache 2.0. We build in the open because this kind of infrastructure should be shared, challenged, and improved by the community. Fork it, break it, make it better.

### Status

We're in the experimental phase — actively building toward complete, production-ready products. The architecture is proven, the demos work end-to-end, and the core services are deployed. What's ahead is hardening, extracting modules, and closing the gaps for real-world adoption. Early adopters and contributors welcome.

### Contact

- tgarciai@underpassai.com
- contact@underpassai.com
