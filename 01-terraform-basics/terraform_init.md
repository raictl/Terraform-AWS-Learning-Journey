# Terraform Basics: `terraform init`

## 📚 Introduction

`terraform init` is the **first command** you run in a Terraform project. It initializes the working directory by downloading the required provider plugins, configuring the backend, and preparing the project for Terraform operations.

> **Rule:** Run `terraform init` once after creating a new project or whenever provider/backend configurations change.

---

# Learning Objectives

After completing this lesson, you will be able to:

- Understand the purpose of `terraform init`
- Initialize a Terraform project
- Download provider plugins
- Understand `.terraform/` and `.terraform.lock.hcl`
- Know when to rerun `terraform init`
- Troubleshoot common initialization issues

---

# Syntax

```bash
terraform init
```

Common options:

```bash
terraform init -upgrade
terraform init -reconfigure
terraform init -backend=false
```

---

# What does `terraform init` do?

It performs the following tasks:

- Initializes the working directory
- Downloads required provider plugins
- Initializes backend configuration
- Downloads Terraform modules (if any)
- Creates `.terraform/`
- Creates/updates `.terraform.lock.hcl`

---

# Internal Workflow

```text
Developer
    │
    ▼
terraform init
    │
    ▼
Read *.tf files
    │
    ▼
Identify required providers
    │
    ▼
Download provider plugins
    │
    ▼
Initialize backend
    │
    ▼
Create .terraform/
    │
    ▼
Generate .terraform.lock.hcl
    │
    ▼
Ready for terraform plan
```

---

# Example

## versions.tf

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

Run:

```bash
terraform init
```

Expected Output:

```text
Initializing the backend...

Initializing provider plugins...

Terraform has been successfully initialized!
```

---

# Important Files Created

## `.terraform/`

Stores:

- Downloaded providers
- Downloaded modules
- Terraform internal metadata

**Do NOT commit this directory to Git.**

---

## `.terraform.lock.hcl`

Stores:

- Provider version
- Provider checksum
- Provider source

**Commit this file to Git.**

---

# Project Structure

Before:

```text
project/
├── main.tf
├── provider.tf
├── versions.tf
└── variables.tf
```

After:

```text
project/
├── .terraform/
├── .terraform.lock.hcl
├── main.tf
├── provider.tf
├── versions.tf
└── variables.tf
```

---

# Common Use Cases

### New Terraform Project

```bash
terraform init
```

---

### Provider Version Changed

```bash
terraform init
```

---

### Backend Changed

```bash
terraform init -reconfigure
```

---

### Upgrade Provider

```bash
terraform init -upgrade
```

---

### CI/CD Pipeline

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

---

# Common Errors

## Error

```text
Terraform has not been initialized.
```

Solution:

```bash
terraform init
```

---

## Error

```text
Failed to query available provider packages
```

Possible Reasons:

- Internet issue
- Wrong provider name
- Proxy/Firewall restriction

---

## Error

```text
Backend configuration changed
```

Solution:

```bash
terraform init -reconfigure
```

---

# Best Practices

✅ Always run `terraform init` first.

✅ Commit `.terraform.lock.hcl`.

✅ Ignore `.terraform/`.

✅ Pin provider versions.

✅ Re-run after provider or backend changes.

---

# Security Best Practices

- Use trusted providers.
- Verify provider versions.
- Never commit credentials.
- Store Terraform state securely (e.g., S3 backend).

---

# Real Production Workflow

```text
Git Clone
    │
    ▼
terraform init
    │
    ▼
terraform fmt
    │
    ▼
terraform validate
    │
    ▼
terraform plan
    │
    ▼
Code Review
    │
    ▼
terraform apply
```

---

# Important Interview Questions

## 1. What is `terraform init`?

**Answer:**
It initializes a Terraform working directory by downloading providers, initializing the backend, and preparing the project.

---

## 2. Why is `terraform init` required?

**Answer:**
Without initialization, Terraform cannot communicate with cloud providers or manage infrastructure.

---

## 3. What is stored inside `.terraform/`?

**Answer:**

- Provider plugins
- Downloaded modules
- Internal Terraform metadata

---

## 4. Should `.terraform/` be committed to Git?

**Answer:**
No.

It contains downloaded dependencies and machine-specific files.

---

## 5. Should `.terraform.lock.hcl` be committed?

**Answer:**
Yes.

It ensures every team member uses the same provider version.

---

## 6. Difference between `.terraform/` and `.terraform.lock.hcl`?

| `.terraform/` | `.terraform.lock.hcl` |
|--------------|------------------------|
| Directory | File |
| Stores downloaded providers | Stores provider versions & checksums |
| Ignore in Git | Commit to Git |

---

## 7. When should you rerun `terraform init`?

- New project
- Provider changed
- Backend changed
- Module added
- Provider version updated

---

## 8. What does `terraform init -upgrade` do?

**Answer:**
Downloads newer provider versions allowed by the version constraints.

---

## 9. What does `terraform init -reconfigure` do?

**Answer:**
Reinitializes backend configuration without reusing previous backend settings.

---

## 10. Can you run `terraform plan` without `terraform init`?

**Answer:**
No.

Terraform will fail because the working directory is not initialized.

---

# Quick Revision

- First Terraform command
- Downloads providers
- Initializes backend
- Creates `.terraform/`
- Creates `.terraform.lock.hcl`
- Required before `plan` and `apply`
- Commit `.terraform.lock.hcl`
- Ignore `.terraform/`

---

# Cheat Sheet

| Command | Purpose |
|----------|---------|
| `terraform init` | Initialize project |
| `terraform init -upgrade` | Upgrade providers |
| `terraform init -reconfigure` | Reconfigure backend |
| `terraform init -backend=false` | Skip backend initialization |

---

# Mini Practice

```bash
mkdir terraform-init-lab
cd terraform-init-lab

terraform init
```

Observe:

- `.terraform/`
- `.terraform.lock.hcl`

---

# Summary

`terraform init` is the foundation of every Terraform project. It prepares the working directory by downloading providers, initializing the backend, and creating essential metadata files. Every Terraform workflow starts with this command, making it one of the most frequently used and important commands in both development and production environments.
