# Terraform Production Workflow

> Learn how professional DevOps teams use Terraform in production with Git, code reviews, CI/CD, remote state, approvals, and controlled deployments.

---

# 📖 Overview

In production, Terraform is **not** run directly from a developer's laptop.

Instead, infrastructure changes follow a controlled workflow involving:

- Version Control (Git)
- Pull Requests (PR)
- Code Review
- CI/CD Pipeline
- Terraform Plan
- Approval Process
- Terraform Apply
- Monitoring

This reduces human errors and ensures infrastructure changes are auditable and repeatable.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand the Terraform production workflow
- Learn the role of Git and CI/CD
- Understand approval-based deployments
- Follow enterprise best practices

---

# Why Do We Need a Production Workflow?

Imagine a developer accidentally changes:

```hcl
instance_type = "t3.micro"
```

to

```hcl
instance_type = "c7i.8xlarge"
```

If they run:

```bash
terraform apply
```

directly in production:

- ❌ Unexpected costs
- ❌ No peer review
- ❌ No approval
- ❌ Difficult auditing

A structured workflow prevents these mistakes.

---

# Production Workflow

```text
Developer
      │
      ▼
Write Terraform Code
      │
      ▼
terraform fmt
      │
      ▼
terraform validate
      │
      ▼
Git Commit
      │
      ▼
Push to Feature Branch
      │
      ▼
Pull Request (PR)
      │
      ▼
Code Review
      │
      ▼
CI/CD Pipeline
      │
      ▼
terraform init
      │
      ▼
terraform plan -out=tfplan
      │
      ▼
Review Plan
      │
      ▼
Approval
      │
      ▼
terraform apply tfplan
      │
      ▼
AWS Infrastructure Updated
      │
      ▼
Monitoring & Verification
```

---

# Example Scenario

A team needs to launch a new application server.

Infrastructure changes include:

- Create a private subnet
- Create a Security Group
- Launch an EC2 instance
- Attach an IAM Role

The developer updates the Terraform configuration and submits a Pull Request.

The CI/CD pipeline validates the code and generates an execution plan.

After approval, the saved plan is applied to production.

---

# CI/CD Pipeline

Typical pipeline stages:

```text
Checkout Code
      │
      ▼
terraform fmt -check
      │
      ▼
terraform validate
      │
      ▼
terraform init
      │
      ▼
terraform plan -out=tfplan
      │
      ▼
Manual Approval
      │
      ▼
terraform apply tfplan
```

This ensures only reviewed changes reach production.

---

# Remote State

Production teams use a shared backend.

Example:

```text
Terraform
      │
      ▼
Remote Backend
      │
      ▼
AWS Infrastructure
```

Benefits:

- Shared state
- Centralized management
- Team collaboration
- Better security
- State versioning
- Coordinated updates

---

# Git Workflow

```text
main
 │
 ├── feature/vpc
 │
 ├── feature/ec2
 │
 └── feature/rds
```

Developers work on feature branches.

Only reviewed code is merged into the main branch.

---

# Code Review Checklist

Before approving a Pull Request:

- Is the code formatted?
- Does validation succeed?
- Is the execution plan reviewed?
- Are unnecessary resource replacements expected?
- Are security changes intentional?
- Are naming conventions followed?

---

# Deployment Approval

Production deployments often require approval from:

- Senior DevOps Engineer
- Platform Team
- Cloud Architect
- Change Advisory Board (CAB) in regulated environments

Approval helps reduce operational risk.

---

# Monitoring After Deployment

After `terraform apply`, verify:

- EC2 instance health
- Security Group rules
- Route table associations
- Load Balancer health checks
- Application availability
- Cloud monitoring and logs

Infrastructure deployment is complete only after successful verification.

---

# Best Practices

- Never apply directly to production from a personal laptop.
- Store Terraform code in Git.
- Require Pull Request reviews.
- Use remote state.
- Save execution plans before applying.
- Follow the principle of least privilege for Terraform credentials.
- Automate validation in CI/CD.

---

# Common Mistakes

### Applying Without Review

May introduce unintended infrastructure changes.

---

### Direct Changes in AWS Console

Causes infrastructure drift.

---

### Shared AWS Credentials

Avoid using personal AWS accounts or shared credentials for automation.

---

### Ignoring Monitoring

Successful deployment does not always mean the application is healthy.

---

# Troubleshooting

| Problem | Solution |
|----------|----------|
| Pipeline validation failed | Fix formatting or configuration errors |
| Plan shows unexpected changes | Review configuration and state |
| Apply failed | Check provider logs, IAM permissions, and AWS service limits |
| Drift detected | Review manual infrastructure changes |

---

# Security Considerations

- Store secrets outside Terraform code.
- Use IAM roles instead of long-term access keys where possible.
- Restrict access to the remote backend.
- Enable backend encryption.
- Enable audit logging for infrastructure changes.

---

# Interview Questions

### 1. Why shouldn't developers run Terraform directly in production?

Because production changes should be reviewed, approved, and executed through controlled CI/CD pipelines.

---

### 2. Why is `terraform plan -out` used in production?

It creates a reviewed execution plan that can be applied later without recalculating changes.

---

### 3. Why is Git important for Terraform?

Git provides version control, collaboration, code reviews, and an audit history for infrastructure changes.

---

### 4. What role does CI/CD play?

CI/CD automates validation, planning, and deployment while reducing manual errors.

---

### 5. Why is remote state important?

It provides a shared source of truth for infrastructure and supports collaborative workflows.

---

### 6. What should happen after `terraform apply`?

Verify that the infrastructure and the deployed application are functioning correctly.

---

### 7. What causes infrastructure drift?

Manual changes made outside Terraform or changes introduced by other automation tools.

---

# 📋 Cheat Sheet

| Stage | Activity |
|--------|----------|
| Develop | Write Terraform code |
| Validate | `terraform fmt` + `terraform validate` |
| Plan | `terraform plan -out=tfplan` |
| Review | Pull Request & plan review |
| Approve | Manual approval |
| Deploy | `terraform apply tfplan` |
| Verify | Monitor infrastructure and application |

---

# 📝 Summary

A production Terraform workflow combines version control, automated validation, peer reviews, execution plans, approvals, and remote state to deliver infrastructure changes safely. Following this workflow minimizes deployment risks, improves collaboration, and provides a reliable audit trail, making it the standard approach for enterprise Infrastructure as Code.
