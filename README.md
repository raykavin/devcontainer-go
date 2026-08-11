# Go Devcontainer Template

[![Go Devcontainer](https://img.shields.io/badge/Go%20Devcontainer-blue?style=flat&logo=go)](https://github.com/raykavin/devcontainer-go)

Single-container Go template optimized for AI coding agents interactive setup and persistent caches.

## Purpose

Provide one consistent environment where an AI agent (or you) can build, run, test, and lint a Go backend from the same shell no container hopping, no per-machine setup.

## Project Layout

```
.devcontainer/   Development container: compose, Dockerfile, post-create
cmd/             Application entrypoints (e.g. cmd/api)
internal/        Application code (hexagonal architecture)
configs/         Configuration files (*.example.yml versioned, real files gitignored)
scripts/sh/      Build/deploy/test/swagger/healthcheck scripts, invoked by the Makefile
Dockerfile       Production image (multi-stage Alpine, non-root)
Makefile         Task entry point
AGENTS.md        Instructions for AI coding agents
init.sh          Interactive configurator
```

## How to Use

### 1. Clone

```sh
git clone https://github.com/raykavin/devcontainer-go.git my-project
cd my-project
```

### 2. Configure

```sh
./init.sh
```

Asks each option with a sensible default (press Enter to accept):

```
Project name [my-app]:
Go version (1.26/1.25) [1.26]:
Timezone [America/Belem]:
Git user.name / user.email / origin URL / initial branch
```

At the end it offers to delete itself and open VS Code directly inside the dev container (`code --folder-uri vscode-remote://dev-container+...`), so the build starts without the "Reopen in Container" click. Answer `n` to keep the script; it is idempotent and can be re-run at any time (then use "Dev Containers: Rebuild Container").

All values live in `.devcontainer/devcontainer.json` (`containerEnv`) and `.devcontainer/docker-compose.yml` (build args), so editing by hand also works.

### 3. First start

`post-create.sh` runs automatically and:

1. Initializes (or validates) the Git repository and configures `user.name` / `user.email` / `origin`
2. Sets up the private Go proxy if `GO_PROXY_HOST` / `GO_PROXY_PORT` are set
3. Runs `go mod init $PROJECT_NAME` (if `go.mod` is absent) and installs Go tools (`gopls`, `goimports`, `dlv`, `staticcheck`, `golangci-lint`)
4. Sets fish as the default shell

### Reuse in an existing project

Copy `.devcontainer/`, `Makefile`, and `AGENTS.md` into any Go project. The post-create script skips every step whose result already exists (`.git`, `go.mod`).

## Development vs Production

|               | Development                                          | Production                                  |
| ------------- | ---------------------------------------------------- | ------------------------------------------- |
| Backend image | `mcr.microsoft.com/devcontainers/go` (prebuilt, MCR) | `Dockerfile` (multi-stage Alpine, non-root) |

```sh
docker build -f Dockerfile -t myapp-api:1.0.0 .
# or: make build
```

## Makefile Targets

```
make run       # Run the Go application
make test      # Run tests
make lint      # golangci-lint
make build     # Production image
make deploy    # Push the production image
make mocks     # Generate mocks (MOCK_ARGS=...)
make swagger   # Generate Swagger docs
```

## Persistent Caches

Named volumes survive container rebuilds:

```
go_bin        →  /go/bin
go_pkg        →  /go/pkg
claude_code   →  ~/.claude   (Claude Code credentials, settings, history — if installed manually)
```

## AI Agents

- `AGENTS.md` at the root documents every command and convention Claude Code and similar tools read it automatically
- The Claude Code CLI is **not** installed automatically; install it manually inside the container if you use it (`npm install -g @anthropic-ai/claude-code`) — its state persists across rebuilds via the `claude_code` volume

## Notes

- This is a personal template, meant to evolve over time
- Default shell inside the container is fish
- Go versions offered by `init.sh` are the ones with `-trixie` tags on `mcr.microsoft.com/devcontainers/go`

---

Built to make Go development with AI agents easier.
