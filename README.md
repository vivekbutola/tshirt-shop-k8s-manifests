# GitOps Repository for Amazon EKS Deployment

![GitOps](https://img.shields.io/badge/GitOps-ArgoCD-red)
![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-blue)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)

---

# Overview

This repository serves as the GitOps source of truth for deploying a containerized PHP application to Amazon Elastic Kubernetes Service (EKS).

Instead of applying Kubernetes manifests manually, ArgoCD continuously monitors this repository and synchronizes the desired application state with the Kubernetes cluster. Any approved change committed to this repository is automatically deployed to Amazon EKS through ArgoCD's automated synchronization.

This separation of application source code and deployment manifests follows GitOps best practices by keeping Continuous Integration (CI) and Continuous Delivery (CD) responsibilities independent.

---

# Repository Purpose

This repository contains the Kubernetes manifests required to deploy the application.

It is responsible for:

- Kubernetes Namespace
- Application Deployment
- Kubernetes Service
- Desired Kubernetes State
- GitOps-based Continuous Delivery

The repository intentionally does not contain application source code or Docker build files.

---

# GitOps Workflow

```
Developer
      │
      ▼
Application Repository
      │
GitHub Actions
      │
Build Docker Image
      │
Trivy Security Scan
      │
Push Image
      ▼
Amazon ECR
      │
Update Kubernetes Manifest
      ▼
GitOps Repository
      │
ArgoCD monitors repository
      │
Automatic Sync
      ▼
Amazon EKS
      │
Running Application
```

---

# ArgoCD Deployment

ArgoCD was deployed inside the Amazon EKS cluster in a dedicated `argocd` namespace using the official ArgoCD installation manifests.

An ArgoCD Application resource was configured to monitor this repository and synchronize Kubernetes resources automatically.

The synchronization policy was configured with:

- Automated Sync
- Self Heal
- Prune

This ensures the Kubernetes cluster always matches the desired state stored in Git.

---

# Repository Structure

```
tshirt-shop-k8s-manifests/

namespace.yaml

api-deployment.yaml

api-service.yaml
```

---

# Kubernetes Resources

## Namespace

Creates an isolated namespace for the application.

```
namespace.yaml
```

---

## Deployment

Deploys the PHP API application.

Configured with:

- Replica Management
- Resource Requests
- Resource Limits
- Kubernetes Secrets
- Readiness Probe
- Liveness Probe
- Security Context
- Amazon ECR Image

---

## Service

Exposes the application using an AWS Network Load Balancer.

Service Type

```
LoadBalancer
```

AWS automatically provisions an NLB for external access.

---

# Production Practices Demonstrated

- GitOps
- Infrastructure as Code
- Declarative Kubernetes Manifests
- Amazon EKS
- Amazon ECR Integration
- Namespace Isolation
- Kubernetes Secrets
- Resource Requests & Limits
- Readiness Probes
- Liveness Probes
- Container Security Context
- AWS Network Load Balancer Integration
- Continuous Delivery using ArgoCD

---

# Related Repositories

### Infrastructure

terraform-k8s

Provision AWS infrastructure including Amazon EKS, VPC and Amazon ECR using Terraform.

---

### Application

tshirt-shop-api

Contains the PHP application, Dockerfile, GitHub Actions pipeline and Docker image build process.

---

# Future Improvements

- Horizontal Pod Autoscaler (HPA)
- Ingress Controller
- Helm Charts
- External Secrets Operator
- ArgoCD Image Updater
- Multi-environment GitOps (Dev/UAT/Production)

---

# Author

**Vivek Butola**

DevOps Engineer | AWS | Terraform | Kubernetes | GitOps | ArgoCD
