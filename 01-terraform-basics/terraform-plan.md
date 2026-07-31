# Terraform Basics - Lesson 04: `terraform plan`

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-Basics-623CE4?style=for-the-badge&logo=terraform&logoColor=white">
  <img src="https://img.shields.io/badge/Level-Beginner-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Cloud-AWS-orange?style=for-the-badge&logo=amazonaws">
</p>

---

## 📖 Overview

`terraform plan` is one of the most important Terraform commands. It generates an **execution plan** that shows exactly what Terraform will do **before** making any changes to your infrastructure.

Instead of directly creating, modifying, or deleting cloud resources, Terraform first compares:

- Your Terraform configuration (`*.tf`)
- The current Terraform state (`terraform.tfstate`)
- The actual infrastructure in the cloud

It then displays a detailed preview of the proposed changes, allowing you to review them before applying.

> **Golden Rule:** Never run `terraform apply` without reviewing the output of `terraform plan`.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand the purpose of `terraform plan`
- Read and interpret execution plans
- Understand resource action symbols (`+`, `-`, `~`, `-/+`)
- Save execution plans for later use
- Use `terraform plan` in production workflows
- Troubleshoot common planning errors
- Follow industry best practices

---

# 📌 Prerequisites

Before running `terraform plan`, ensure you have already executed:

```bash
terraform init
terraform fmt
terraform validate
```

---

# 🤔 Why Do We Need `terraform plan`?

Imagine you're about to renovate your house.

Would you allow a contractor to begin demolition without showing you the design?

Probably not.

Instead, you expect:

- A list of planned changes
- Estimated work
- Cost implications
- Items being removed
- New items being added

Terraform works the same way.

Instead of directly changing infrastructure, it first generates a **preview** of every action.

This helps prevent:

- Accidental resource deletion
- Unexpected infrastructure changes
- Downtime
- Human mistakes
- Production outages

---

# 🚀 What Problem Does It Solve?

Without `terraform plan`:

```text
Developer
      │
      ▼
terraform apply
      │
      ▼
Infrastructure Changed
```

No review.

No verification.

High risk.

With `terraform plan`:

```text
Developer
      │
      ▼
terraform plan
      │
      ▼
Review Changes
      │
      ▼
Approved?
   │        │
  Yes      No
   │        │
   ▼        ▼
terraform  Fix Code
 apply
```

This review process is why Terraform is trusted in enterprise environments.

---

# ⚙️ Internal Working

When you execute:

```bash
terraform plan
```

Terraform performs several internal steps.

```text
Developer

      │

      ▼

terraform plan

      │

      ▼

Read *.tf Files

      │

      ▼

Read terraform.tfstate

      │

      ▼

Query Cloud Provider

(AWS API)

      │

      ▼

Compare Desired State

vs

Current State

      │

      ▼

Generate Execution Plan

      │

      ▼

Display Proposed Changes
```

---

# 🏗 How Terraform Thinks

Terraform compares three sources of information.

```text
                Desired State
               (Terraform Code)
                      │
                      │
                      ▼
              Terraform Engine
              (Execution Plan)
                 ▲         ▲
                 │         │
                 │         │
       Terraform State   Real AWS Infrastructure
       (terraform.tfstate)
```

If all three match,

Terraform displays:

```
No changes.
Infrastructure is up-to-date.
```

---

# 📝 Syntax

Basic syntax:

```bash
terraform plan
```

Save the execution plan:

```bash
terraform plan -out=tfplan
```

Specify variables:

```bash
terraform plan \
-var="environment=dev"
```

Use a variable file:

```bash
terraform plan \
-var-file=terraform.tfvars
```

Generate a detailed exit code:

```bash
terraform plan -detailed-exitcode
```

---

# 📂 Example Project

```
terraform-s3-demo/

├── provider.tf
├── versions.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── main.tf
```

Example:

```hcl
resource "aws_s3_bucket" "demo" {

  bucket = "ashu-demo-bucket"

}
```

Run:

```bash
terraform plan
```

Terraform will compare the desired bucket with AWS and determine whether:

- The bucket should be created
- Updated
- Replaced
- Deleted
- Left unchanged

---

# 📊 Understanding Plan Symbols

Terraform uses symbols to indicate actions.

| Symbol | Meaning | Description |
|---------|----------|-------------|
| `+` | Create | Resource will be created |
| `-` | Destroy | Resource will be deleted |
| `~` | Update | Resource will be modified |
| `-/+` | Replace | Destroy old resource and create a new one |

Example:

```
+ aws_s3_bucket.demo
```

Meaning:

Terraform will create a new S3 bucket.

---

Example:

```
~ aws_instance.web
```

Meaning:

Terraform will update an existing EC2 instance.

---

Example:

```
- aws_security_group.old
```

Meaning:

Terraform will destroy the security group.

---

Example:

```
-/+ aws_instance.web
```

Meaning:

Terraform cannot modify this resource in place.

It must:

1. Delete it
2. Create a new one

This usually happens when changing immutable properties such as certain instance attributes or resource names, depending on the provider.

---

# 💻 Hands-on Lab

## Step 1

Initialize the project.

```bash
terraform init
```

---

## Step 2

Validate the configuration.

```bash
terraform validate
```

---

## Step 3

Generate the execution plan.

```bash
terraform plan
```

Expected output:

```
Terraform will perform the following actions:

+ aws_s3_bucket.demo

Plan: 1 to add, 0 to change, 0 to destroy.
```

This means:

- One resource will be created
- Nothing will change
- Nothing will be destroyed


---

# 💾 Saving an Execution Plan

Instead of immediately applying the generated plan, you can save it to a file.

```bash
terraform plan -out=tfplan
```

Output:

```text
Plan: 1 to add, 0 to change, 0 to destroy.

Saved the plan to: tfplan
```

The generated `tfplan` file contains the execution plan in a binary format and is intended to be used with:

```bash
terraform apply tfplan
```

### Why Save a Plan?

In production environments, the engineer who reviews the changes is often **not** the one who applies them.

Typical workflow:

```text
Developer
    │
    ▼
terraform plan -out=tfplan
    │
    ▼
Code Review / Approval
    │
    ▼
terraform apply tfplan
```

This ensures the reviewed plan is exactly the one that gets applied.

> **Note:** A saved plan is binary and should not be edited manually.

---

# 📌 Exit Codes (`-detailed-exitcode`)

By default, `terraform plan` returns:

- `0` → Success (whether or not changes exist)

For automation, this is not sufficient.

Use:

```bash
terraform plan -detailed-exitcode
```

Return codes:

| Exit Code | Meaning |
|-----------|---------|
| **0** | Success, **no changes** |
| **1** | Error |
| **2** | Success, **changes detected** |

### CI/CD Example

```bash
terraform plan -detailed-exitcode

case $? in
0)
  echo "Infrastructure already matches configuration."
  ;;
1)
  echo "Terraform plan failed."
  exit 1
  ;;
2)
  echo "Changes detected."
  ;;
esac
```

This is commonly used in GitHub Actions, GitLab CI, Jenkins, and Azure DevOps pipelines.

---

# 🌍 Real-World Use Cases

## 1. Pull Request Review

Before merging Terraform code:

```bash
terraform fmt
terraform validate
terraform plan
```

The team reviews the plan before approving the PR.

---

## 2. Production Deployment

A DevOps engineer generates the plan:

```bash
terraform plan -out=prod.tfplan
```

The operations team reviews it.

After approval:

```bash
terraform apply prod.tfplan
```

---

## 3. Infrastructure Change Audit

Execution plans provide visibility into:

- Resources to be created
- Resources to be modified
- Resources to be destroyed

This reduces the risk of accidental production outages.

---

## 4. CI/CD Pipelines

Typical pipeline:

```text
Git Push
    │
    ▼
terraform fmt -check
    │
    ▼
terraform validate
    │
    ▼
terraform plan
    │
    ▼
Manual Approval
    │
    ▼
terraform apply
```

---

# ❌ Common Errors

## Error: Terraform has not been initialized

```text
Error: Terraform has not been initialized.
```

### Cause

You skipped:

```bash
terraform init
```

### Solution

```bash
terraform init
```

---

## Error: No AWS Credentials

```text
Error: No valid credential sources found
```

### Cause

Terraform cannot authenticate with AWS.

### Solution

Configure credentials using one of the supported methods, for example:

- AWS CLI (`aws configure`)
- Environment variables
- IAM Role (EC2)
- AWS SSO

---

## Error: Access Denied

```text
AccessDenied
```

### Cause

The IAM identity lacks required permissions.

### Solution

Grant the necessary IAM permissions for the resources Terraform is planning to manage.

---

## Error: Invalid Reference

```text
Reference to undeclared resource
```

### Cause

Your configuration references a resource that doesn't exist.

### Solution

Correct the resource name or define the missing resource.

---

# 🔧 Troubleshooting Guide

| Problem | Possible Cause | Solution |
|----------|---------------|----------|
| Initialization error | `terraform init` not run | Run `terraform init` |
| Provider issue | Provider not installed | Re-run `terraform init` |
| Authentication failed | Missing credentials | Configure AWS credentials |
| Invalid reference | Typo in resource name | Correct the reference |
| Validation failure | Invalid HCL | Run `terraform validate` |

---

# ⭐ Best Practices

### ✅ Always Review the Plan

Never run:

```bash
terraform apply
```

without reviewing:

```bash
terraform plan
```

---

### ✅ Save Production Plans

```bash
terraform plan -out=prod.tfplan
```

Apply the approved plan instead of generating a new one later.

---

### ✅ Keep Plans Short-Lived

A saved plan reflects the infrastructure at the time it was created.

If infrastructure changes later, generate a fresh plan.

---

### ✅ Validate Before Planning

```bash
terraform fmt
terraform validate
terraform plan
```

---

### ✅ Review Resource Deletions Carefully

If you see:

```text
-
```

or

```text
-/+
```

verify that the deletion or replacement is intentional before applying.

---

# 🔐 Security Considerations

- Do not commit saved plan files (`*.tfplan`) to Git.
- Review plans for accidental resource deletions.
- Avoid exposing sensitive variable values.
- Use least-privilege IAM permissions.
- Protect Terraform state, as it may contain sensitive information.

---

# ⚡ Performance Tips

- Keep state files small by organizing infrastructure into modules or separate state files.
- Use remote state for team collaboration.
- Run plans only against the required workspace/environment.
- Avoid unnecessary provider upgrades during routine planning.

---

# 🎤 Interview Questions & Answers

## 1. What is `terraform plan`?

**Answer:**
It generates an execution plan that previews the infrastructure changes Terraform intends to make without applying them.

---

## 2. Does `terraform plan` create resources?

**Answer:**
No. It only shows the proposed changes.

---

## 3. Why should you run `terraform plan` before `terraform apply`?

**Answer:**
It helps verify changes, detect mistakes, and prevent accidental infrastructure modifications.

---

## 4. What does the `+` symbol mean?

**Answer:**
A new resource will be created.

---

## 5. What does the `~` symbol mean?

**Answer:**
An existing resource will be updated in place.

---

## 6. What does the `-` symbol mean?

**Answer:**
The resource will be destroyed.

---

## 7. What does the `-/+` symbol mean?

**Answer:**
Terraform must replace the resource because it cannot perform the requested change in place.

---

## 8. What is the purpose of `terraform plan -out=tfplan`?

**Answer:**
It saves the execution plan so the exact reviewed plan can later be applied.

---

## 9. Why use `terraform plan -detailed-exitcode`?

**Answer:**
It provides different exit codes for automation, allowing CI/CD pipelines to detect whether changes exist.

---

## 10. Can two consecutive `terraform plan` commands produce different results?

**Answer:**
Yes. Infrastructure drift, code changes, variable changes, or updates to external data sources can change the execution plan.

---

## 11. Is a saved plan portable across different environments?

**Answer:**
No. A saved plan is tied to the specific configuration, state, and environment in which it was created.

---

## 12. What is infrastructure drift?

**Answer:**
It occurs when the real infrastructure differs from Terraform's recorded state or configuration, often due to manual changes outside Terraform.

---

# 📋 Quick Revision

- `terraform plan` previews infrastructure changes.
- No resources are created during planning.
- Review every plan before applying.
- Use `-out` for production approval workflows.
- Use `-detailed-exitcode` for CI/CD automation.
- Watch for `-` and `-/+` actions carefully.

---

# 📄 Cheat Sheet

| Command | Purpose |
|----------|---------|
| `terraform plan` | Generate execution plan |
| `terraform plan -out=tfplan` | Save execution plan |
| `terraform apply tfplan` | Apply saved execution plan |
| `terraform plan -var="key=value"` | Pass variable value |
| `terraform plan -var-file=terraform.tfvars` | Use variable file |
| `terraform plan -detailed-exitcode` | Return automation-friendly exit codes |

---

# 📚 Official Documentation

- https://developer.hashicorp.com/terraform/cli/commands/plan
- https://developer.hashicorp.com/terraform/language

---

# 📝 Summary

`terraform plan` is one of the most critical commands in the Terraform workflow. It acts as a safety checkpoint by comparing your desired configuration with the current state and actual infrastructure, then displaying the exact actions Terraform intends to perform. Reviewing execution plans before applying changes is a fundamental best practice that reduces risk, improves collaboration, and forms the basis of safe Infrastructure as Code deployments in production environments.
