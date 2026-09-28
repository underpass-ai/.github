## Underpass AI

**Memory, coordination, and execution infrastructure for reliable AI agents.**

Website: [underpassai.com](https://underpassai.com)

Underpass AI builds the infrastructure layer around models: a coordination
plane that runs auditable deliberations among councils of specialist agents, a
memory plane that agents can navigate and audit, and an execution plane that
governs how agents act on real systems.

We do not build foundation models. We build the operational substrate that
makes them safer, more useful, and easier to inspect in production.

### What We Build

**Memory plane — [KMP by Underpass](https://github.com/underpass-ai/kmp)**
gives Codex, Claude Code and Hermes Agent local-first memory. It stores decisions
and evidence in SQLite, with explicit clocks and relations that preserve what
changed, why it changed and what proves it. Agents recover scoped context, ask
for stored evidence, navigate history and audit the original sources. `UNKNOWN`
is an explicit outcome when the selected memory cannot answer.

**ChronoLoom** gives the person and the agent a shared view of that memory:
timelines, about layers, filters and proof paths. The person can take control
or undo a view move. A progressive guide teaches the agent how to use the live
MCP tools.

- **Local / embedded — the default.** The kernel runs inside the MCP process,
  with no database server, KMP account or hosted service required. Multiple local
  hosts can share SQLite memory. Native plugins support Codex and Claude Code;
  native setup supports Hermes. Reviewed portable bundles carry project memory
  between machines.
- **Shared service — optional and self-operated.** Typed gRPC APIs backed by
  Neo4j, Valkey and NATS JetStream, with Helm/Kubernetes deployment, TLS/mTLS and
  observability. Operators own the infrastructure, identity and authorization.
  Backend-specific capabilities are documented rather than assumed identical.

Default embedded retrieval needs no external model. Optional TypeSafe Jev
features send selected text to an external service for judgments; an optional
semantic encoder runs locally. Evidence returned to a cloud agent also follows
that host's data policy. Your agent writes the final answer from the evidence.

[Install KMP](https://github.com/underpass-ai/kmp#install-and-initialize-your-memory)
· [Embedded memory](https://github.com/underpass-ai/kmp/blob/main/docs/embedded/README.md)
· [Explore ChronoLoom](https://github.com/underpass-ai/kmp/tree/main/crates/kmp-viewer)

**Coordination plane — MADE by Underpass** — [Multi-Agent Deliberation Engine](https://github.com/underpass-ai/made)
runs structured deliberations (propose → peer-critique → revise → validate → score → winner)
and longer declarative YAML ceremonies as explicit state machines. Enforces output contracts,
can score with an LLM judge, and ships observability that shows *why* an answer won.
Domain- and provider-agnostic. Kubernetes-first.

**Execution plane — [Underpass Runtime](https://github.com/underpass-ai/underpass-runtime)**
provides isolated workspaces, governed tool execution, policy checks,
telemetry, and adaptive tool recommendations for tool-driven agents.

Together these three planes form **infrastructure, not an application**. Any domain that
needs institutional memory plus governed action can be built on top.

### How It Works

Underpass is designed to run alongside existing infrastructure. Operational
systems produce domain events. MADE convenes a council of specialist agents that
investigate real systems, recover relevant memory through KMP, act through governed
runtime tools, and record evidence back into memory.

```text
Domain event fires
  -> MADE convenes a specialist agent council
    -> Agents investigate the real system
      -> KMP restores scoped memory and navigable timelines
        -> Runtime governs tool execution
          -> Evidence is recorded
            -> The next similar event starts with better memory
```

The common pattern:

```text
domain event -> orchestration -> agent -> memory -> governed action -> evidence -> better memory
```

### Why It Matters

Reliable agents need memory they can navigate, not just context they can retrieve.

For real agentic work, it is not enough to ask which text chunk looks similar.
The system also needs to answer:

- what was known at a given moment;
- which attempt failed;
- what changed later;
- which agent introduced a wrong assumption;
- why one answer replaced another;
- which evidence supports the final result.

KMP by Underpass is built around that model: memory as a temporal, inspectable,
multidimensional graph, not just raw transcript replay or vector search over
chunks.

### Repositories

| Plane | Repository | Language | What it provides |
| --- | --- | --- | --- |
| **Memory** | [`kmp`](https://github.com/underpass-ai/kmp) | Rust | KMP by Underpass: local SQLite memory, decisions and evidence, temporal navigation, auditable relations, shared ChronoLoom view, native agent setup and optional self-operated gRPC service |
| **Coordination** | [`made`](https://github.com/underpass-ai/made) | Rust | MADE: structured deliberation, YAML ceremonies, LLM-as-judge scoring, event-driven dispatch, output contracts, deliberation-native observability; use-case- and provider-agnostic; API-first |
| **Execution** | [`underpass-runtime`](https://github.com/underpass-ai/underpass-runtime) | Go | Isolated workspaces, governed tools, policy checks, adaptive tool recommendation, telemetry, mTLS, Kubernetes-oriented execution |

The `rehydration-*` names are historical repository and artifact names. The
public memory product name is **KMP by Underpass**.

### Architecture: What We Own

| Component | Ownership | Examples |
| --- | --- | --- |
| **KMP by Underpass** | Underpass | Memory protocol, temporal traversal, graph inspection, evidence model, embedded distribution |
| **MADE by Underpass** | Underpass | Council deliberation, YAML ceremonies, LLM-as-judge scoring, event-driven dispatch |
| **Underpass Runtime** | Underpass | Governed tools, execution isolation, policy checks |
| **Integration adapter** | Product/team using Underpass | Alert relay, CI/CD hooks, ERP connectors, domain event emitters |
| **Application services** | Product/team using Underpass | payments-api, order-svc, internal platforms |
| **Observability and CI/CD** | Product/team using Underpass | Prometheus, Grafana, PagerDuty, GitHub Actions, ArgoCD |

### Production-Oriented Foundations

- **API first**: KMP behavior is defined by typed gRPC and domain contracts;
  MCP is an agent-facing adapter over the same memory semantics.
- **Explicit scope**: memory reads are scoped by current `about`, selected
  abouts, or intentionally global reads.
- **Temporal traversal**: `kmp_time` moves through explicit clocks with `goto`,
  `near`, `rewind` and `forward`; `kmp_trace` and `kmp_inspect` audit paths and sources.
- **Evidence and provenance**: recovered memory carries refs, proof, relation
  metadata, and traceability.
- **Fail-fast behavior**: invalid scopes and unsafe fallbacks are rejected
  instead of silently widening a query.
- **Observability**: structured logs, metrics, traces, and relation-quality
  signals make memory behavior auditable.
- **Infrastructure boundaries**: TLS/mTLS, Kubernetes deployment, Helm tests,
  and adapter-based persistence roles.

### Currently Building

**Auditable multi-agent deliberation** — ceremonies that turn a meeting of
specialist agents into a first-class artifact: the winning contribution of
each step returned over the API, the full debate replayable as a distributed
trace in Grafana/Tempo, and the health of the decision process — judge
discrimination, winner-score distribution, provider saturation, token cost —
measured as Prometheus metrics.

**Replayable operational memory for AI agents** — a memory layer that lets
people and LLMs inspect what happened, what each agent knew, where the process
forked, which evidence mattered, and why the final resolution worked.

KMP's current public capabilities include:

- local SQLite memory shared by Codex, Claude Code and Hermes Agent;
- native installation workflows and a progressive guide for agents;
- anchored Ask with explicit answered, partial and unknown outcomes;
- a local lexical index for eligible reads, with ordinary retrieval as fallback;
- optional model-assisted retrieval and source-bound search expansions;
- ChronoLoom exploration shared between the person and the agent.

See the [KMP changelog](https://github.com/underpass-ai/kmp/blob/main/CHANGELOG.md)
for released changes and work still marked Unreleased. Retrieval experiments
carry their own measurements and limits; they are not general accuracy claims.

### Articles

- [No queremos agentes que contesten. Queremos decisiones que se puedan auditar](https://dev.to/tirsogarcia/no-queremos-agentes-que-contesten-queremos-decisiones-que-se-puedan-auditar-11gm)
- [Operator: cuando responder no basta](https://dev.to/tirsogarcia/operator-cuando-responder-no-basta-2kna)
- [Building Kernel Memory Protocol: Navigable Memory for AI Agents](https://dev.to/tirsogarcia/building-kernel-memory-protocol-navigable-memory-for-ai-agents-315j)
- [Construyendo Kernel Memory Protocol: memoria navegable para agentes de IA](https://dev.to/tirsogarcia/construyendo-kernel-memory-protocol-memoria-navegable-para-agentes-de-ia-24lc)
- [What an event-driven agent pipeline looks like when you trace it end-to-end](https://dev.to/tirsogarcia/what-an-event-driven-agent-pipeline-looks-like-when-you-trace-it-end-to-end-1cck)
- [Why event-driven agents reduce scope, cost, and decision dispersion](https://dev.to/tirsogarcia/why-event-driven-agents-reduce-scope-cost-and-decision-dispersion-2062)

### Status

KMP is pre-1.0 and actively evolving. Its default embedded path stores memory
locally in SQLite and exposes it through MCP, with ChronoLoom for visual
inspection. The optional remote API is versioned `v1beta1` and requires an
operator. Installation, backend limits and release status are maintained in the
[KMP repository](https://github.com/underpass-ai/kmp).

MADE runs council deliberations and YAML ceremonies end-to-end against live
vLLM-served models on Kubernetes, with an optional LLM judge, the debate exported
as OpenTelemetry traces over mTLS, and a deliberation-specific Prometheus metrics
suite served at `/metrics`.

The project is active and evolving quickly. Public repositories are released
under Apache-2.0 unless stated otherwise.

### Ownership

Underpass AI is a project created by
[Tirso Garcia Ibañez](https://github.com/tgarciai).

### Contact

[LinkedIn](https://www.linkedin.com/in/tirsogarcia/) ·
[GitHub](https://github.com/tgarciai)

- tgarciai@underpassai.com
- contact@underpassai.com
