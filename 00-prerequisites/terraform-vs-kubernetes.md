# Lesson 06: Terraform vs Kubernetes

> Learn the difference between Terraform and Kubernetes, understand their roles, and discover how they work together in production.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand what Kubernetes is.
- Compare Terraform and Kubernetes.
- Know when to use each tool.
- Explain how they complement each other.
- Answer Terraform vs Kubernetes interview questions.

---

# 📖 What is Kubernetes?

Kubernetes (K8s) is an open-source Container Orchestration platform.

It is used to:

- Deploy containers
- Scale applications
- Perform rolling updates
- Self-heal failed containers
- Manage application workloads

---

# 📖 What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool.

It is used to:

- Create infrastructure
- Modify infrastructure
- Destroy infrastructure
- Automate cloud resource provisioning

---

# 🏗️ Everyday Example

Imagine opening a restaurant.

## Terraform

Terraform builds the restaurant.

It creates:

- Land
- Building
- Electricity
- Kitchen
- Parking

## Kubernetes

Kubernetes manages the restaurant after it opens.

It:

- Assigns chefs
- Serves customers
- Replaces sick workers
- Expands staff during busy hours

Terraform builds.

Kubernetes operates.

---

# ⚙️ Production Workflow

```
Terraform
      │
Creates
      │
      ▼
VPC
EC2
Load Balancer
Storage
Networking
      │
      ▼
Kubernetes Cluster
      │
      ▼
Deploy Applications
Scale Pods
Rolling Updates
Self Healing
```

---

# ⚖️ Comparison

| Terraform | Kubernetes |
|------------|------------|
| Infrastructure as Code | Container Orchestration |
| Creates Cloud Infrastructure | Runs Containerized Applications |
| Creates VPC | Runs Pods |
| Creates EC2 | Runs Containers |
| Creates Networking | Manages Deployments |
| Creates Load Balancers | Scales Applications |
| Uses HCL | Uses YAML |

---

# 🏢 Production Example

Terraform provisions:

- VPC
- Subnets
- Internet Gateway
- Security Groups
- EC2
- EKS Cluster

After the infrastructure is ready,

Kubernetes deploys:

- Frontend
- Backend
- Database Pods
- Ingress
- Services
- ConfigMaps
- Secrets

---

# ⭐ Best Practices

- Use Terraform for infrastructure provisioning.
- Use Kubernetes for application deployment.
- Store infrastructure and Kubernetes manifests separately.
- Keep everything under version control.
- Avoid manually modifying infrastructure managed by Terraform.

---

# ❌ Common Mistakes

- Using Terraform to manage every Kubernetes object.
- Expecting Kubernetes to create cloud networking.
- Confusing infrastructure management with application orchestration.

---

# 💼 Interview Question

### What is the difference between Terraform and Kubernetes?

Terraform provisions infrastructure such as VPCs, EC2 instances, storage, and Kubernetes clusters. Kubernetes manages applications running inside those clusters by scheduling containers, scaling workloads, and recovering from failures. Terraform builds the platform, while Kubernetes runs the applications.

---

# 📝 Revision Notes

- Terraform creates infrastructure.
- Kubernetes manages applications.
- Terraform uses HCL.
- Kubernetes uses YAML.
- Both work together in production.

---

# 📋 Cheat Sheet

| Task | Tool |
|------|------|
| Create VPC | Terraform |
| Create EKS Cluster | Terraform |
| Deploy Pods | Kubernetes |
| Scale Applications | Kubernetes |
| Rolling Updates | Kubernetes |
| Self Healing | Kubernetes |

---

# 🧪 Mini Lab

Draw a simple architecture showing:

Internet

↓

AWS

↓

VPC

↓

EC2

↓

Kubernetes Cluster

↓

Pods

Then explain which components are managed by Terraform and which are managed by Kubernetes.

---

# 🔑 Key Takeaways

- Terraform provisions infrastructure.
- Kubernetes manages applications.
- They solve different problems.
- They are commonly used together in production.
- Terraform creates the platform; Kubernetes runs the workloads.

---
