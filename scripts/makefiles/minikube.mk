

mk-start: mk-install mk-config
	minikube start

mk-config:
	minikube config set memory 10000
	minikube config set cpus 6
	minikube delete

mk-stop:
	minikube stop

mk-dashboard:
	minikube dashboard

.SILENT: mk-install
mk-install: k-install
	if ! command -v minikube > /dev/null 2>&1; then \
		curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64 && \
		sudo install minikube-linux-arm64 /usr/local/bin/minikube && \
		rm minikube-linux-arm64; \
	else \
		echo "minikube is already installed."; \
	fi
