@echo off

set LITMUS_DASHBOARD_ENDPOINT="http://127.0.0.1:9091" 
set LITMUS_DASHBOARD_USER="jenkins"
set LITMUS_DASHBOARD_PASSWORD="jenkins"
set LITMUS_PROJECT_ID="bfe5d049-0ffc-4364-a134-168d6b935e30"
set CHAOS_DELEGATE_NAME="jenkins-agent"

:: First, we deploy our execution environment
minikube start -p jenkins-cloud-cluster
minikube start -p litmus-dashboard-cluster
docker run -d --name jenkins --network="jenkins-cloud-cluster" -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts-jdk11

:: We connect litmus-dashboard-cluster to the same network as jenkins slave cluster and container
minikube stop -p litmus-dashboard-cluster
docker network disconnect litmus-dashboard-cluster litmus-dashboard-cluster
docker network connect jenkins-cloud-cluster litmus-dashboard-cluster
minikube start -p litmus-dashboard-cluster

:: We deploy LitmusChaos in litmus-dashboard-cluster
kubectl config use-context litmus-dashboard-cluster
kubectl apply -f https://litmuschaos.github.io/litmus/2.14.0/litmus-2.14.0.yaml

:: We expose ChaosCenter frontend service through LoadBalancer
kubectl patch svc litmusportal-frontend-service -n litmus --type=json -p "[{\"op\":\"replace\",\"path\":\"/spec/type\",\"value\":\"LoadBalancer\"}]"
start cmd /C minikube tunnel -p litmus-dashboard-cluster

:: We configure litmusctl
litmusctl config set-account --endpoint "%LITMUS_DASHBOARD_ENDPOINT%" --username "%LITMUS_DASHBOARD_USER%" --password "%LITMUS_DASHBOARD_PASSWORD%"

:: We create a chaos-delegate in jenkins-cloud-cluster and connect it to ChaosCenter
kubectl config use-context jenkins-cloud-cluster 
litmusctl connect chaos-delegate --name="%CHAOS_DELEGATE_NAME%" --project-id="%LITMUS_PROJECT_ID%" --non-interactive

echo "Demo environment created."