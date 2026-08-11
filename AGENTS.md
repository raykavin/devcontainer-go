# AGENTS.md

Guidance for AI coding agents (Claude Code, etc.) working in this repository.

## Repository layout

```
cmd/           Application entrypoints (e.g. cmd/api)
internal/      Application code (hexagonal architecture)
configs/       Configuration files
scripts/sh/    Build/deploy/test/swagger/healthcheck scripts
Makefile       Entry point for all common tasks
```

See `.claude/AGENTS.md` for the detailed backend development standard (architecture, conventions, testing, security).

## Commands

| Task           | Command        |
| -------------- | -------------- |
| Run             | `make run` (serves on :3000)  |
| Tests           | `make test`    |
| Lint            | `make lint`    |
| Production image | `make build` |

## Conventions

- Go code follows idiomatic Go: minimal abstraction, compile-time safety, no framework magic.
- All code comments in English.
- Lint before finishing any task: `make lint`.

## Caches (do not delete)

- `/go/bin` and `/go/pkg` are persistent volumes (Go tools and modules).
- `~/.claude` is a persistent volume (Claude Code credentials and settings).
