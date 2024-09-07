.DEFAULT_GOAL := help

# Python related variables
PYTHON := .venv/bin/python3

# Image / container related variables
IMAGE_NAME := duckdb-query## Docker image name
CONTAINER_NAME := duckdb-query-container## Docker container name
PORT := 8080## Exposed port on host

# Kubernetes related variables
K8S_NAMESPACE := default## Kubernetes namespace

delete-venv: ## Delete Virtual Environment on devcontainer
	rm -rf .venv

re-venv: delete-venv venv ## Rebuild Virtual Environment on devcontainer

venv: ## Really Simple Virtual Environment on devcontainer
	uv sync

.PHONY: setup-duckdb
setup-duckdb: ## Setup DuckDB with seed data
	@echo "Setting up DuckDB with seed data..."
	@${PYTHON} setup_duckdb.py

# Build Docker image
.PHONY: build-image
build-image: ## Build Docker image for DuckDB query
	@echo "Building Docker image: ${IMAGE_NAME}"
	@docker build -t ${IMAGE_NAME}:latest .

# Deploy to Kubernetes
.PHONY: deploy-k8s
deploy-k8s: build-image ## Deploy to Kubernetes
	@echo "Deploying to Kubernetes..."
	@kubectl apply -f k8s-duckdb-config.yaml -n ${K8S_NAMESPACE}

# Run query in Kubernetes
.PHONY: run-query
run-query: ## Run DuckDB query in Kubernetes
	@echo "Running DuckDB query in Kubernetes..."
	@kubectl get pods -n ${K8S_NAMESPACE} -l app=duckdb-query -o jsonpath='{.items[0].metadata.name}' | xargs -I {} kubectl logs {} -n ${K8S_NAMESPACE}

# Clean up Kubernetes resources
.PHONY: clean-k8s
clean-k8s: ## Remove Kubernetes resources
	@echo "Cleaning up Kubernetes resources..."
	@kubectl delete -f k8s-duckdb-config.yaml -n ${K8S_NAMESPACE}

include scripts/makefiles/*.mk

# Help target (assuming it's defined in one of the included makefiles)
# If not, you might want to add it here