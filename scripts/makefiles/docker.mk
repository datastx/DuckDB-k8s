
# Build Docker image
.PHONY: build-image
build-image: ## Build Docker image for DuckDB query
	@echo "Building Docker image: ${IMAGE_NAME}"
	@docker build -t ${IMAGE_NAME}:latest .
