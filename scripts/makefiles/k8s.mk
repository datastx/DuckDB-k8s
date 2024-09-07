
# Deploy to Kubernetes
.PHONY: deploy-k8s
deploy-k8s: build-image ## Deploy to Kubernetes
	@echo "Deploying to Kubernetes..."
	@kubectl apply -f k8s-duckdb-config.yaml -n ${K8S_NAMESPACE}



# Clean up Kubernetes resources
.PHONY: clean-k8s
clean-k8s: ## Remove Kubernetes resources
	@echo "Cleaning up Kubernetes resources..."
	@kubectl delete -f k8s-duckdb-config.yaml -n ${K8S_NAMESPACE}
