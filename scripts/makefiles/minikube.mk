

minikube-start:
	minikube start --driver=docker --alsologtostderr -v=7 --force

minikube-stop:
	minikube stop