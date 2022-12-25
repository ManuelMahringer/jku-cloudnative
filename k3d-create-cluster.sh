#!/bin/bash
#create a k3d cluster with definition file
k3d cluster create --config ./k3d/k3d-local-dev-cluster.yaml
#create namespace for the argocd installation
kubectl create namespace argocd
# install argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Set fixed password
kubectl -n argocd patch secret argocd-secret \
	  -p '{"stringData": {
    "admin.password": "$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa",
        "admin.passwordMtime": "'$(date +%FT%T%Z)'"
	  }}'

# start the GitOps with creation of argo-cd app
kubectl -n argocd apply -f ./argo-cd/argo-cd-app.yaml
