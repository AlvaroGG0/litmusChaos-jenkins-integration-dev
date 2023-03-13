# (DEMO) LITMUS CHAOS IN JENKINS PIPELINE

A demo showing how to use LitmusChaos in CI pipelines with Jenkins and Minikube using Docker.

## Requirements

- [Docker](https://www.docker.com/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [litmusctl](https://docs.litmuschaos.io/docs/2.14.0/litmusctl/installation)

### Jenkins Plugins

- [Kubernetes](https://plugins.jenkins.io/kubernetes/) (to connect and configure our jenkins slave cluster)
- [Kubernetes CLI](https://plugins.jenkins.io/kubernetes-cli/) (to allow us to execute kubectl commands from pipelines pods)

## Environment

- **Clusters**
  - `Litmus-dashboard-cluster`: cluster where Litmus Dashboard (ChaosCenter) and control-plane are deployed.
  - `Jenkins-cloud-cluster`: Jenkins slave cluster where pipelines are executed.

- **Docker containers**
  - `Jenkins`: docker container where Jenkins master is running.

*All instances must be deployed in the same Docker network so they can interact with each other.*
