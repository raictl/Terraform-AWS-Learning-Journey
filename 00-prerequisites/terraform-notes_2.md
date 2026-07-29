# Lesson 03: Why Terraform?

> Understand why Terraform became the industry standard for Infrastructure as Code.

---

# Learning Objectives

After this lesson, you will be able to:

- Explain why Terraform is used.
- Describe the problems Terraform solves.
- Understand why companies prefer Terraform.
- Answer interview questions about Terraform benefits.

---

# Why Was Terraform Created?

Before Terraform:

- Infrastructure was created manually.
- Human errors were common.
- Every engineer followed different steps.
- Disaster recovery was slow.
- Infrastructure changes were difficult to track.

Terraform solved these challenges by introducing Infrastructure as Code.

---

# Problems Terraform Solves

## 1. Automation

Instead of manually creating infrastructure, Terraform automates provisioning.

```
Write Code

↓

terraform apply

↓

Infrastructure Created
```

---

## 2. Consistency

Terraform ensures identical environments.

- Development
- Testing
- Staging
- Production

---

## 3. Version Control

Infrastructure code is stored in Git.

Benefits:

- Track changes
- Review changes
- Rollback
- Collaboration

---

## 4. Repeatability

Need another environment?

Run the same code again.

Terraform recreates the infrastructure consistently.

---

## 5. Disaster Recovery

If infrastructure is lost:

```bash
terraform apply
```

Terraform recreates the infrastructure from code.

---

## 6. Multi-Cloud

Terraform supports:

- AWS
- Azure
- Google Cloud
- Kubernetes
- VMware
- Many more providers

---

# Real Production Example

A production application requires:

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- EC2
- RDS
- Load Balancer
- Auto Scaling

Terraform creates all of these from code, making deployments faster and more reliable.

---

# Best Practices

- Store Terraform code in Git.
- Review plans before applying.
- Keep infrastructure modular.
- Avoid manual cloud changes.
- Reuse modules.

---

# Common Mistakes

- Editing infrastructure manually.
- Hardcoding credentials.
- Keeping everything in one file.
- Not using version control.

---

# Interview Question

### Why do companies use Terraform?

Companies use Terraform because it automates infrastructure provisioning, reduces manual errors, provides consistent deployments, supports version control, enables disaster recovery, and works across multiple cloud providers.

---

# Revision Notes

- Automation
- Consistency
- Version Control
- Repeatability
- Disaster Recovery
- Multi-cloud

---

# Cheat Sheet

| Benefit | Description |
|----------|-------------|
| Automation | Faster deployments |
| Consistency | Same infrastructure everywhere |
| Version Control | Infrastructure tracked in Git |
| Repeatability | Easy recreation |
| Disaster Recovery | Fast recovery |
| Multi-cloud | One tool for multiple platforms |

---

# Mini Lab

Create a file named:

```bash
touch terraform-benefits.md
```

Write:

- Five benefits of Terraform.
- Why companies use Terraform.
- A real-world Terraform use case.

---

# Key Takeaways

- Terraform reduces manual work.
- Infrastructure becomes repeatable.
- Git tracks infrastructure changes.
- Teams collaborate more efficiently.
- Production deployments become reliable.

---

