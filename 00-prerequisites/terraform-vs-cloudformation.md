# Lesson 04: Terraform vs AWS CloudFormation

> Learn the differences between Terraform and AWS CloudFormation, understand when to use each tool, and prepare for DevOps interview questions.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Explain what AWS CloudFormation is.
- Compare Terraform and CloudFormation.
- Identify the strengths and weaknesses of each tool.
- Decide which tool to use in different scenarios.
- Answer interview questions confidently.

---

# 📖 What is AWS CloudFormation?

AWS CloudFormation (CFN) is AWS's native Infrastructure as Code (IaC) service.

It allows you to provision and manage AWS infrastructure using JSON or YAML templates.

CloudFormation manages only AWS resources.

---

# 📖 What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp.

It allows you to provision infrastructure across multiple cloud providers and platforms using HashiCorp Configuration Language (HCL).

---

# 🏗️ How They Work

## AWS CloudFormation

```
CloudFormation Template
        │
        ▼
CloudFormation
        │
        ▼
AWS Resources
```

---

## Terraform

```
Terraform Code
        │
        ▼
Terraform
        │
        ▼
AWS Provider
        │
        ▼
AWS API
        │
        ▼
AWS Resources
```

---

# ⚖️ Comparison

| Feature | Terraform | CloudFormation |
|----------|-----------|----------------|
| Developed By | HashiCorp | AWS |
| Cloud Support | Multi-cloud | AWS Only |
| Language | HCL | YAML / JSON |
| State Management | State File | Managed by AWS |
| Modules | Excellent | Nested Stacks |
| Community | Large | AWS-focused |
| Portability | High | AWS Only |
| Learning Curve | Beginner Friendly | Moderate |

---

# 🌍 Multi-Cloud Support

Terraform supports:

- AWS
- Azure
- Google Cloud
- Kubernetes
- VMware
- GitHub
- Cloudflare
- Datadog
- Hundreds of other providers

CloudFormation supports:

- AWS only

---

# 🏢 Production Example

A company uses:

- AWS
- Kubernetes
- GitHub
- Cloudflare

Terraform can manage all of them with one workflow.

CloudFormation can manage only AWS resources.

---

# ✅ When to Use Terraform

Choose Terraform when:

- Working with multiple cloud providers.
- Managing Kubernetes.
- Reusing modules.
- Standardizing infrastructure across environments.
- Managing cloud and SaaS providers together.

---

# ✅ When to Use CloudFormation

Choose CloudFormation when:

- Your infrastructure is entirely on AWS.
- You prefer AWS-native services.
- Your organization has standardized on CloudFormation.

---

# ⭐ Best Practices

- Keep infrastructure code in Git.
- Review changes before deployment.
- Reuse modules.
- Avoid manual infrastructure changes.
- Use one IaC tool consistently within a project.

---

# ❌ Common Mistakes

- Assuming Terraform replaces AWS.
- Assuming CloudFormation supports Azure or GCP.
- Mixing manual changes with IaC-managed resources.

---

# 💼 Interview Question

### Why is Terraform often preferred over CloudFormation?

Terraform is preferred because it supports multiple cloud providers and platforms, provides reusable modules, uses an easy-to-read language (HCL), and offers a consistent workflow across different environments.

---

# 📝 Revision Notes

- CloudFormation is AWS-native.
- Terraform is multi-cloud.
- Terraform uses HCL.
- CloudFormation uses YAML or JSON.
- Both are Infrastructure as Code tools.

---

# 📋 Cheat Sheet

| Goal | Recommended Tool |
|------|------------------|
| AWS Only | CloudFormation or Terraform |
| Multi-cloud | Terraform |
| Kubernetes + AWS | Terraform |
| Hybrid Cloud | Terraform |

---

# 🧪 Mini Lab

Create a comparison table with at least 7 differences between Terraform and CloudFormation.

---

# 🔑 Key Takeaways

- Both automate infrastructure.
- Terraform supports multiple providers.
- CloudFormation is limited to AWS.
- Terraform is widely adopted for multi-cloud environments.
- Choose the tool based on business requirements.

---

