# Go Devcontainer Template

[![Go Devcontainer](https://img.shields.io/badge/Go%20Devcontainer-blue?style=flat&logo=go)](https://github.com/raykavin/devcontainer-go)

<p align="start">
  <img src="https://lh3.googleusercontent.com/d/1aAfhxEWyqv5uD6F3Moj3vvpYyHN7KsoN" alt="go-dev-template" width="120"/>
</p>


Personal **Dev Container** template for **Golang** development, focused a ready-to-use environment.

## Purpose

Provide a consistent Go development environment using **Dev Containers**, eliminating manual setup and machine-specific differences. Configure once, use everywhere.

## What's Included

| Component | Description |
|---|---|
| `Dockerfile.dev` | Dev image based on `devcontainers/go:1.25-trixie` with Fish shell |
| `Dockerfile` | Multi-stage production build (Alpine, non-root user) |
| `docker-compose.dev.yml` | Dev compose with persistent Go cache volumes |
| `.devcontainer/devcontainer.json` | VS Code Dev Container configuration |
| `.devcontainer/post-create.sh` | Auto-setup script (Git, Go modules, tools) |
| `Makefile` | Common project tasks |
| `.env.example` | Environment variable template |

## VS Code Extensions

Pre-installed in the container:

- **golang.Go** - Official Go extension
- **neonxp.gotools** / **tooltitudeteam.tooltitude** - Go tooling
- **liuchao.go-struct-tag** - Struct tag editing
- **yokoe.vscode-postfix-go** - Postfix completions
- **usernamehw.errorlens** - Inline error display
- **mhutchie.git-graph** - Git history visualization
- **redhat.vscode-yaml** - YAML support
- **streetsidesoftware.code-spell-checker** (+ PT-BR) - Spell checking

## Go Tools Installed Automatically

- `gopls` - Language server
- `goimports` - Import management
- `dlv` - Debugger
- `staticcheck` - Static analysis
- `golangci-lint` - Linter aggregator

## How to Use

### 1. Clone and open

```bash
git clone https://github.com/raykavin/devcontainer-go.git my-project
cd my-project
code .
```

When VS Code prompts, select **"Reopen in Container"**.

### 2. Configure the container

Edit `.devcontainer/devcontainer.json` and set the environment variables:

```jsonc
"containerEnv": {
    "PROJECT_NAME": "my-application",                                 // Go module name and binary name
    "GIT_CONFIG_DEV_USERNAME": "Your Name",                           // Git user.name for commits
    "GIT_CONFIG_DEV_EMAIL": "you@example.com",                        // Git user.email for commits
    "GIT_REPO_ADDRESS": "https://github.com/you/my-application.git",  // Git remote URL for origin
    "GIT_INIT_DEFAULT_BRANCH": "feat/initial-setup",                  // Default branch name if repo is initialized
    "TZ": "America/Belem"                                             // Timezone for the container 
}
```

### 3. What happens on first start

The `post-create.sh` script runs automatically and:

1. Initializes (or validates) the Git repository and configures `user.name` / `user.email`
2. Adds or updates the `origin` remote
3. Initializes Go modules (`go mod init $PROJECT_NAME`) if `go.mod` is absent
4. Installs all Go development tools
5. Runs `golangci-lint` for an initial code check
6. Checks out the `feat/initial-setup` branch if it exists

### Reuse in an existing project

Copy only the `.devcontainer` folder into any Go project:

```bash
cp -r devcontainer-go/.devcontainer /path/to/your-project/
```

## Go Cache Volumes

The compose file mounts persistent volumes for Go's binary and package cache:

```
../.docker/go/bin  →  /go/bin
../.docker/go/pkg  →  /go/pkg
```

This keeps downloaded modules and compiled tools between container rebuilds, making subsequent starts significantly faster.

## Makefile Targets

```bash
make build    # Build production Docker image
make deploy   # Deploy the image
make test     # Run tests
make mocks    # Generate mocks
make swagger  # Generate Swagger docs
make help     # List all targets
```

Scripts are expected under `scripts/sh/`.

## Production Build

The `Dockerfile` uses a two-stage build:

- **Build stage** - `golang:1.25.7-alpine3.23` with CGO enabled
- **Runtime stage** - `alpine:3.22` with a dedicated non-root user

Configurable via build args: `GO_BUILD_FLAGS`, `PROJECT_NAME`, `TZ`, `APP_USER_ID`, `APP_GROUP_ID`.

## Environment Variables

Copy `.env.example` to `.env` and fill in the values before starting services:

```bash
cp .env.example .env
```

## Notes

- This is a **personal template**, meant to evolve over time
- Go version, tools, extensions, and project structure can be fully customized
- Default shell inside the container is **Fish**

---

Built to make Go development easier.
