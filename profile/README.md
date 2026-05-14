## Underpass AI

**Memory and execution infrastructure for reliable AI agents.**

Website: [underpassai.com](https://underpassai.com)

Underpass AI builds the infrastructure layer around models: a memory plane that
agents can navigate and audit, and an execution plane that governs how agents
act on real systems.

We do not build foundation models. We build the operational substrate that
makes them safer, more useful, and easier to inspect in production.

### What We Build

**Memory plane** — [Underpass KMP](https://github.com/underpass-ai/rehydration-kernel)
is a Kernel Memory Protocol for temporal, multidimensional, auditable agent
memory. It exposes an API-first `KernelMemoryService` gRPC boundary for memory
ingest, deterministic `Wake`/`Ask`, temporal traversal, graph path tracing, and
node inspection. Memory is scoped by `about`, split into dimensions, connected
by explicit relationships, and backed by evidence and provenance.

**Execution plane** — [Underpass Runtime](https://github.com/underpass-ai/underpass-runtime)
provides isolated workspaces, governed tool execution, policy checks,
telemetry, and adaptive tool recommendations for tool-driven agents.

Together they form **infrastructure, not an application**. Any domain that
needs institutional memory plus governed action can be built on top.

### How It Works

Underpass is designed to run alongside existing infrastructure. Operational
systems produce domain events. Specialist agents investigate real systems,
recover relevant memory through KMP, act through governed runtime tools, and
record evidence back into memory.

```text
Domain event fires
  -> Specialist agent investigates the real system
    -> KMP restores scoped memory and navigable timelines
      -> Runtime governs tool execution
        -> Evidence is recorded
          -> The next similar event starts with better memory
```

The common pattern:

```text
domain event -> agent -> memory -> governed action -> evidence -> better memory
```

### Why It Matters

Reliable agents need memory they can navigate, not just context they can
retrieve.

For real agentic work, it is not enough to ask which text chunk looks similar.
The system also needs to answer:

- what was known at a given moment;
- which attempt failed;
- what changed later;
- which agent introduced a wrong assumption;
- why one answer replaced another;
- which evidence supports the final result.

Underpass KMP is built around that model: memory as a temporal, inspectable,
multidimensional graph, not just raw transcript replay or vector search over
chunks.

### Repositories

| Plane | Repository | Language | What it provides |
| --- | --- | --- | --- |
| **Memory** | [`rehydration-kernel`](https://github.com/underpass-ai/rehydration-kernel) | Rust | Underpass KMP: typed `KernelMemoryService`, deterministic memory retrieval, multidimensional memory, temporal traversal, trace/inspect, evidence-backed `Ask`, MCP adapter, Helm/Kubernetes deployment |
| **Execution** | [`underpass-runtime`](https://github.com/underpass-ai/underpass-runtime) | Go | Isolated workspaces, governed tools, policy checks, adaptive tool recommendation, telemetry, mTLS, Kubernetes-oriented execution |

The `rehydration-*` names are historical repository and artifact names. The
public memory product name is **Underpass KMP**.

### Architecture: What We Own

| Component | Ownership | Examples |
| --- | --- | --- |
| **Underpass KMP** | Underpass | Memory protocol, temporal traversal, graph inspection, evidence model |
| **Underpass Runtime** | Underpass | Governed tools, execution isolation, policy checks |
| **Integration adapter** | Product/team using Underpass | Alert relay, CI/CD hooks, ERP connectors, domain event emitters |
| **Application services** | Product/team using Underpass | payments-api, order-svc, internal platforms |
| **Observability and CI/CD** | Product/team using Underpass | Prometheus, Grafana, PagerDuty, GitHub Actions, ArgoCD |

### Production-Oriented Foundations

- **API first**: KMP behavior is defined by typed gRPC and domain contracts;
  MCP is an agent-facing adapter over the same memory semantics.
- **Explicit scope**: memory reads are scoped by current `about`, selected
  abouts, or intentionally global reads.
- **Temporal traversal**: callers can move through memory with `goto`, `near`,
  `rewind`, `forward`, `trace`, and `inspect`.
- **Evidence and provenance**: recovered memory carries refs, proof, relation
  metadata, and traceability.
- **Fail-fast behavior**: invalid scopes and unsafe fallbacks are rejected
  instead of silently widening a query.
- **Observability**: structured logs, metrics, traces, and relation-quality
  signals make memory behavior auditable.
- **Infrastructure boundaries**: TLS/mTLS, Kubernetes deployment, Helm tests,
  and adapter-based persistence roles.

### Currently Building

**Replayable operational memory for AI agents** — a memory layer that lets
people and LLMs inspect what happened, what each agent knew, where the process
forked, which evidence mattered, and why the final resolution worked.

Current focus areas:

- stronger MemoryArena, MemoryAgentBench, and LongMemEval evaluations;
- hybrid retrieval, reranking, and typed domain plugins;
- visual graph and timeline exploration for traversing agent memory;
- a small operator model trained to use KMP/MCP tools efficiently;
- embedded and installable distributions that reduce infrastructure
  requirements while preserving KMP semantics.

### Articles

- [Building Kernel Memory Protocol: Navigable Memory for AI Agents](https://dev.to/tirsogarcia/building-kernel-memory-protocol-navigable-memory-for-ai-agents-315j)
- [Construyendo Kernel Memory Protocol: memoria navegable para agentes de IA](https://dev.to/tirsogarcia/construyendo-kernel-memory-protocol-memoria-navegable-para-agentes-de-ia-24lc)

### Status

Core infrastructure is deployed and validated on live Kubernetes clusters with
TLS/mTLS-enabled boundaries. Underpass KMP includes typed gRPC memory APIs,
temporal traversal, graph tracing, node inspection, scoped multidimensional
memory, and an MCP adapter over the same public API.

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
