PROJECT_NAME ?= my-app
VERSION      ?= 1.0.0

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  run                Run the Go application"
	@echo "  test               Run tests"
	@echo "  lint               Run golangci-lint"
	@echo "  build              Build production image (Dockerfile)"
	@echo "  deploy             Push the production image (scripts/sh/deploy.sh)"
	@echo "  mocks              Generate mocks (pass args as MOCK_ARGS)"
	@echo "  swagger            Generate Swagger docs (scripts/sh/swagger.sh)"

.PHONY: run
run:
	@go run ./cmd/api

.PHONY: test
test:
	@go test -v -race ./...

.PHONY: lint
lint:
	@golangci-lint run

.PHONY: build
build:
	@docker build -f Dockerfile \
		--build-arg APP_NAME=$(PROJECT_NAME) \
		-t $(PROJECT_NAME)-api:$(VERSION) .

.PHONY: deploy
deploy:
	@scripts/sh/deploy.sh $(PROJECT_NAME)-api $(VERSION)

.PHONY: mocks
mocks:
	@scripts/sh/generate-mocks.sh $(MOCK_ARGS)

.PHONY: swagger
swagger:
	@scripts/sh/swagger.sh
