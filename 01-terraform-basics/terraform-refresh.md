# Terraform Refresh (`terraform refresh`)

> Learn the purpose of `terraform refresh`, why it was deprecated, and the modern alternatives used in current Terraform workflows.

---

# 📖 Overview

`terraform refresh` was used to **synchronize the Terraform state file with the actual infrastructure**.

It queried the cloud provider, compared the real infrastructure with the Terraform state, and updated the state file **without modifying the actual infrastructure**.

> **Important:** Starting with **Terraform v0.15.4**, the standalone `terraform refresh` command was **deprecated**. Modern Terraform automatically refreshes state during `terraform plan` and `terraform apply`.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand the purpose of `terraform refresh`
- Learn why it was deprecated
- Understand infrastructure drift
- Use modern alternatives
- Troubleshoot state synchronization issues
- Answer interview questions confidently

---

# What Was `terraform refresh`?

Imagine someone manually modifies your AWS infrastructure.

Example:

Terraform created:

```text
EC2 Instance

Type: t2.micro
```

Later, someone changes it manually in AWS Console:

```text
EC2 Instance

Type: t3.micro
```

Terraform's state file still contains:

```text
t2.micro
```

The actual infrastructure contains:

```text
t3.micro
```

Now the state file is outdated.

Running:

```bash
terraform refresh
```

updated the **state file** so it matched the real infrastructure.

---

# Why Was It Needed?

Terraform relies on the state file.

If the state becomes outdated because of:

- Manual changes
- External automation
- Cloud console updates

Terraform may generate incorrect execution plans.

Refreshing ensures Terraform has an accurate view of the infrastructure.

---

# Internal Working

```text
Developer
      │
      ▼
terraform refresh
      │
      ▼
Read terraform.tfstate
      │
      ▼
Query AWS APIs
      │
      ▼
Compare Actual Infrastructure
      │
      ▼
Update terraform.tfstate
```

Notice:

```
Infrastructure

NOT Modified
```

Only the **state file** changed.

---

# Example

Suppose Terraform state contains:

```text
Instance Type

t2.micro
```

AWS actually contains:

```text
Instance Type

t3.micro
```

After refresh:

```text
terraform.tfstate

↓

t3.micro
```

Infrastructure remains unchanged.

Only Terraform's understanding of the infrastructure is updated.

---

# Why Was `terraform refresh` Deprecated?

HashiCorp found that users often misunderstood what the command did.

Many believed it was "safe" because it didn't change infrastructure, but it **could still update the state file**, potentially hiding unexpected drift if run without review.

Instead of a dedicated refresh command, modern Terraform integrates refresh into planning and applying, making the workflow more predictable.

---

# Modern Alternatives

## Option 1 (Recommended)

```bash
terraform plan
```

Modern Terraform automatically refreshes the state before generating the execution plan.

This is the most common workflow.

---

## Option 2

```bash
terraform apply -refresh-only
```

This refreshes the state and records the updated state without making infrastructure changes.

Useful when you want to reconcile state after reviewing detected drift.

---

# Infrastructure Drift

Infrastructure drift occurs when the **real infrastructure** no longer matches the **Terraform configuration** or **Terraform state**.

Example:

Terraform creates:

```text
EC2

t2.micro
```

Administrator changes:

```text
EC2

t3.micro
```

Terraform configuration:

```text
t2.micro
```

Actual AWS:

```text
t3.micro
```

Terraform detects this difference during `terraform plan`.

---

# Real-World Causes of Drift

- Manual AWS Console changes
- AWS CLI modifications
- CloudFormation changes
- Automation scripts
- Another Terraform project
- Emergency production fixes

---

# Production Workflow

```text
Developer
      │
      ▼
terraform plan
      │
      ▼
State Refreshed
      │
      ▼
Drift Detected
      │
      ▼
Review Changes
      │
      ▼
terraform apply
```

---

# Common Use Cases

## Detect Drift

```bash
terraform plan
```

---

## Refresh State Only

```bash
terraform apply -refresh-only
```

---

## Investigate Manual Changes

Compare:

- Terraform configuration
- Terraform state
- Actual cloud resources

---

# Best Practices

- Do not rely on the deprecated `terraform refresh` command.
- Use `terraform plan` to detect drift.
- Use `terraform apply -refresh-only` when appropriate.
- Avoid making manual changes in the cloud console.
- Manage infrastructure exclusively through Terraform whenever possible.

---

# Common Errors

## Drift Detected

```text
Terraform detects unexpected changes.
```

### Cause

Resources were modified outside Terraform.

### Solution

Review the execution plan and decide whether to:

- Accept the drift
- Revert the manual change
- Update the Terraform configuration

---

## State Out of Sync

```text
State does not match infrastructure.
```

### Solution

Run:

```bash
terraform plan
```

or

```bash
terraform apply -refresh-only
```

---

# Troubleshooting Checklist

| Problem | Solution |
|----------|----------|
| Manual resource changes | Review with `terraform plan` |
| State drift | Refresh using modern workflow |
| Incorrect execution plan | Verify configuration and state |
| Unexpected resource updates | Investigate manual changes |

---

# Security Considerations

- Restrict manual infrastructure changes.
- Use IAM policies to limit console access.
- Record all infrastructure changes through version control.
- Enable CloudTrail or equivalent auditing services.

---

# Interview Questions

## 1. What was `terraform refresh`?

It synchronized the Terraform state file with the real infrastructure without modifying infrastructure.

---

## 2. Is `terraform refresh` still recommended?

No.

It has been deprecated since Terraform **v0.15.4**.

---

## 3. Why was it deprecated?

Because its functionality is now integrated into `terraform plan` and `terraform apply`, reducing confusion and encouraging safer workflows.

---

## 4. What is the replacement for `terraform refresh`?

- `terraform plan`
- `terraform apply -refresh-only`

---

## 5. What is infrastructure drift?

Infrastructure drift occurs when the real infrastructure differs from the Terraform configuration or recorded state.

---

## 6. Does `terraform refresh` create resources?

No.

It only updated the Terraform state.

---

## 7. Can Terraform detect manual AWS Console changes?

Yes.

Modern Terraform detects them during `terraform plan`.

---

# Quick Revision

- `terraform refresh` updated the state file.
- It did not create or delete infrastructure.
- Deprecated since Terraform v0.15.4.
- Use `terraform plan` instead.
- Use `terraform apply -refresh-only` when only the state needs updating.
- Understand infrastructure drift.

---

# Cheat Sheet

| Command | Purpose |
|----------|---------|
| `terraform plan` | Refresh state and generate execution plan |
| `terraform apply -refresh-only` | Refresh state without changing infrastructure |
| `terraform refresh` | Deprecated standalone refresh command |

---

# Summary

`terraform refresh` was originally designed to synchronize Terraform's state with the actual infrastructure. As Terraform evolved, HashiCorp integrated state refreshing directly into `terraform plan` and `terraform apply`, making the standalone command unnecessary and eventually deprecating it. Today, understanding infrastructure drift and using the modern workflow are essential Terraform skills for both production environments and technical interviews.
