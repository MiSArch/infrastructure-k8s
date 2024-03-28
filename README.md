# Misarch Kubernetes Infrastructure

## Overview

This repository contains the Terraform scripts responsible for orchestrating the deployment of the Misarch Platform on a Kubernetes cluster.
Additional information on top can be found in the [documentation](https://misarch.github.io/docs/docs/dev-manuals/services/infrastructure-k8s).

> [!WARNING] current progress
> At the moment, the following things are missing in the Kubernetes deployment:
> - querying keycloak results in a `502 Bad Gateway`
> - MongoDB services have not been set up yet
> - There is no predefined ingress at the moment

## Deploying

Initially, run
```sh
terraform init
```
once.

Afterwards, you can set up the cluster using
```sh
terraform apply
```
repeatedly until the cluster is up.
Prepare for a long journey, it may take up to 10 minutes.

## Accessing DB Passwords

All generated DB passwords can be retrieved by calling
```sh
terraform output misarch_${service_name_lowercased}_db_password
```
so for example
```sh
terraform output misarch_catalog_db_password
# Or
terraform output misarch_shoppingcart_db_password
```

## Auto-updating Build

If you want to have a build whose images are always kept up to date instead of fixed to one version, replace `terraform apply` with `terraform apply -var-file="latest-deployment.tfvars"`.\
However, the images will only be updated once you execute
```sh
kubectl -n misarch rollout restart deployment
kubectl -n misarch rollout restart statefulset
```

## Adding a new service

See [the docs](https://misarch.github.io/docs/docs/dev-manuals/kubernetes/adding-a-new-service).

## Deployment Approach

### Terraform and State Management

We employ Terraform as the central tool for infrastructure-as-code, managing every facet of our Kubernetes resources. At the moment, remote state management is not yet configured, mostly due to the inability to use Terraform Cloud as it's not possible to connect to the Kubernetes cluster from outside the university network. This means that the Terraform state files need to be manually transferred to the individual managing the cluster. This is a point of consideration for future improvements.

### Resource Deployment

Our infrastructure consists of a mixture of "raw" Kubernetes resources and Helm-based deployments. All Misarch-services are deployed using raw Kubernetes manifests while we use Helm for standard resources like PostgreSQL databases, Keycloak and Minio to simplify management.

### Ingress Configuration

All services are exposed through an Nginx ingress that is presumed to already exist in the target cluster. This ingress handles routing and SSL termination, providing a unified access point to various services. Currently, self-signed certs are used due to the difficulty of using Let's Encrypt without a public endpoint. While this would be possible using DNS validation, this is complex to setup and requires a supported DNS provider.

## Repository Structure

### General Infrastructure Resources

- **main.tf**: Defines the Kubernetes namespace `misarch` and establishes image pull secrets required for pulling Docker images from external repositories.
- **ingress.tf**: Sets up the Nginx ingress for managing external access. Configurations for SSL redirection and proxy buffer sizes are also defined here. All services to be exposed have to be configured here.
- **dapr.tf**: Deploys the Dapr runtime using Helm charts. Also includes the setup for state and pub-sub components using Redis.
- **keycloak.tf**: Handles the setup for Keycloak, used for identity and access management. It utilizes Helm charts for deployment and includes admin user and password settings.

### Frontend Deployment

In `frontend.tf`, the Misarch frontend is deployed as a Kubernetes Deployment and exposed through a Kubernetes Service. The deployment specifies environment variables for OAuth and backend URL configurations and includes a liveness probe to monitor the health of the frontend service.

### Backend Services Deployment

The backend services are generally structured as follows:

- **Kubernetes Deployment**: Each service is deployed as a Kubernetes Deployment, complete with a Dapr sidecar for http and pub-sub communication.
- **Database**: A Helm-managed PostgreSQL database is associated with each service, configured with a random password and the default db.
- **Optional Resources**: Some services include additional resources like Horizontal Pod Autoscalers or Minio deployments for content storage.

While the individual backend deployments might look repetitive, keeping them separate allows us to adapt each service to its specifics and add additional resources like Minio or autoscalers where necessary.

### GraphQL Gateway Deployment

The GraphQL Gateway, configured in `gateway.tf`, serves as the central entry point for all backend services. It routes incoming HTTP requests to the respective backend services via Dapr. Like other backends, it's deployed as a Kubernetes Deployment and exposed via a Kubernetes Service. An autoscaler and liveness/readiness probes are also configured to ensure scalability and health monitoring.

### Prerequisites

- **Kubernetes Cluster**: A running cluster with admin access, a working Nginx ingress controller, the capability to deploy Persistent Volumes and Load Balancers. Place the cluster credentials in a `kubeconfig.yaml` file within the repository.
- **Terraform CLI**: Ensure you have version >= 1.0.11 installed.
- **University VPN**: If managing the existing cluster, a connection to the university's VPN is required.
- **Terraform State**: For managing the existing cluster, obtain and place the current Terraform state within the repository.

### Getting Started

1. **Clone the Repository**: Clone this Terraform repository to your local machine.
2. **Navigate to the Repo**: Open a terminal and navigate to the repository directory.
3. **Setup**: Ensure all prerequisites are met as outlined in the Prerequisites section.
4. **Initialize Terraform**: Run `terraform init` to initialize the Terraform workspace.
5. **Apply Configuration**: Execute `terraform apply` to deploy the resources to your Kubernetes cluster.

#### Development Build

If you simply want to test whether your deployment will work at all, run `. ./test-deployment.sh` before running `terraform apply`.\
This script populates the bare minimum of variables so that `terraform apply` just works.\
It is not intended for productive use in the slightest.

### Troubleshooting

- **Disappearing Dapr Sidecars**: If Dapr sidecars disappear, causing communication to stop working in the cluster, try restarting the affected deployments.
- **Schema Changes in Services**: If there are schema changes in individual services without changes in the gateway code, a restart of the gateway deployment is required.
- **\<x\> exists already**: When canceling a previous `terraform apply` and re-running `terraform apply`, this error can occur. It means that `terraform` sees state outside of its control. In this case, you have two options: `terraform refresh` may help sometimes. If it does not help, delete the component and try again. In the worst case, execute `kubectl delete namespaces misarch` (or whatever you named your namespace) and try again. We know it's weird, but it seems to be caused by Terraforms design.
- **failed to fetch resource from kubernetes: the server could not find the requested resource**: There are multiple causes for this error, you need to find out which one is applicable for you:
    - Somehow, Dapr seems to have been broken causing its Custom Resource Definitions (CRD) to disappear. Solution: Comment out the entire `dapr` file, run `terraform apply` to remove it from the cluster, and uncomment it again, everything should be working again. Also make sure that Dapr configuration only runs once Dapr has been created. More information: https://github.com/gavinbunney/terraform-provider-kubectl/issues/270
    - Dapr cannot be created successfully. Fix your Dapr configuration
    - Randomly at the end of `terraform apply` but the custom resources have been created: This is the best and worst case at the same time: It means that subsequent `terraform apply`s will most likely succeed. There seems to be a random chance that this "error" occurs when creating the cluster, but it has no effect as everything will be created regardless. However, it remains unclear as to why this error happens in the first place. If it does not work, destroy and re-setup your cluster a few times (highest count needed so far: 4), until it works.
- **Invalid value for "path" parameter: no file exists at "keycloak/keycloak-realm-template.json"**: You need to clone this repo using `git clone --recurse-submodules`

Hint: For easier management and debugging, it helps to use a Kubernetes management UI like Lens to connect to the cluster, restart deployments or setup port forwarding.
