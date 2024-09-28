
.SILENT: k-install
k-install:
	if ! command -v kubectl > /dev/null 2>&1; then \
		VERSION=$$(curl -L -s https://dl.k8s.io/release/stable.txt) && \
		curl -LO "https://dl.k8s.io/release/$$VERSION/bin/linux/arm64/kubectl" && \
		sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl; \
	else \
		echo "kubectl is already installed."; \
	fi
