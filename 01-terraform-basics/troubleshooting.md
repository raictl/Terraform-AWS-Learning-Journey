# Terraform Troubleshooting Guide

> Learn a systematic approach to troubleshooting Terraform issues in development and production environments.

---

# 📖 Overview

Troubleshooting is the process of identifying, analyzing, and resolving Terraform issues.

A good DevOps Engineer doesn't guess—they follow a structured process.

This guide provides a practical troubleshooting workflow that can be applied to most Terraform problems.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Troubleshoot Terraform systematically
- Identify the root cause of failures
- Verify infrastructure changes safely
- Debug Terraform configurations
- Resolve production deployment issues

---

# The Golden Rule

> **Never fix the symptom. Always find the root cause.**

Example:

```text
❌ Wrong Approach

terraform apply failed

↓

Run it again
```

Instead:

```text
✅ Correct Approach

Read Error

↓

Identify Cause

↓

Fix Cause

↓

Verify

↓

Retry
```

---

# Production Troubleshooting Workflow

```text
Problem Reported
        │
        ▼
Read Complete Error Message
        │
        ▼
Identify Failed Resource
        │
        ▼
Check Terraform Configuration
        │
        ▼
Check Terraform State
        │
        ▼
Verify AWS Infrastructure
        │
        ▼
Check IAM Permissions
        │
        ▼
Review Execution Plan
        │
        ▼
Apply Fix
        │
        ▼
Run terraform plan
        │
        ▼
Run terraform apply
        │
        ▼
Verify Deployment
```

---

# Step 1: Read the Error Message

Don't skip the first few lines.

Terraform usually tells you:

- Which resource failed
- Why it failed
- Which file contains the issue
- The approximate line number

Example:

```text
Error:

creating EC2 Instance

UnauthorizedOperation
```

The important information is **UnauthorizedOperation**, not just "Terraform failed."

---

# Step 2: Identify the Resource

Ask yourself:

- Which resource failed?
- Is it an EC2 instance?
- A VPC?
- A Security Group?
- An IAM Role?

Knowing the affected resource narrows your investigation.

---

# Step 3: Validate the Configuration

Run:

```bash
terraform validate
```

Checks:

- Syntax
- Required arguments
- Block structure
- Invalid references

---

# Step 4: Review the Execution Plan

Run:

```bash
terraform plan
```

Check:

- Unexpected resource replacements
- Resources marked for deletion
- Incorrect values
- Drift detection

Never troubleshoot by applying blindly.

---

# Step 5: Verify Terraform State

Useful commands:

```bash
terraform state list
```

```bash
terraform state show aws_instance.web
```

Questions to ask:

- Is the resource tracked?
- Is the state outdated?
- Was it deleted manually?

---

# Step 6: Verify AWS Resources

Open the AWS Console or use the AWS CLI.

Example:

Check EC2:

```bash
aws ec2 describe-instances
```

Check VPCs:

```bash
aws ec2 describe-vpcs
```

Compare actual infrastructure with Terraform's expectations.

---

# Step 7: Verify IAM Permissions

Many Terraform failures are permission-related.

Example:

```text
AccessDenied
```

Check whether the IAM identity can:

- Create
- Modify
- Delete
- Describe

the affected resource.

---

# Step 8: Check Dependencies

Ask:

- Does the VPC exist?
- Is the subnet available?
- Is the Security Group created?
- Is the Internet Gateway attached?

Terraform cannot create dependent resources if prerequisites are missing.

---

# Step 9: Verify Provider Configuration

Example:

```hcl
provider "aws" {

  region = "ap-south-1"

}
```

Check:

- Region
- Credentials
- Profile
- Provider version

---

# Step 10: Retry Safely

After fixing the issue:

```bash
terraform plan
```

Review the proposed changes.

Then:

```bash
terraform apply
```

Never skip the planning step after making corrections.

---

# Troubleshooting Checklist

```text
✓ Read the error carefully

✓ Identify the failed resource

✓ Validate configuration

✓ Review execution plan

✓ Verify Terraform State

✓ Verify AWS resources

✓ Check IAM permissions

✓ Verify dependencies

✓ Confirm provider configuration

✓ Apply the fix

✓ Verify the deployment
```

---

# Real-World Scenario

### Problem

A developer tries to launch an EC2 instance.

Terraform returns:

```text
UnauthorizedOperation
```

### Investigation

- Configuration → Correct
- State → Healthy
- AWS Region → Correct
- IAM Policy → Missing `ec2:RunInstances`

### Solution

Grant the required IAM permission.

Run:

```bash
terraform plan
```

Then:

```bash
terraform apply
```

Deployment succeeds.

---

# Best Practices

- Read the full error message.
- Troubleshoot one problem at a time.
- Keep Terraform configuration under version control.
- Avoid manual changes in AWS.
- Use remote state for teams.
- Review execution plans before applying.

---

# Common Mistakes

### Ignoring Error Details

Focus on the root cause, not just the last line.

---

### Running `terraform apply` Repeatedly

Repeated retries rarely solve configuration or permission issues.

---

### Editing the State File

Use Terraform state commands instead of manual edits.

---

### Skipping Validation

Always run:

```bash
terraform validate
```

before planning.

---

# Interview Questions

### 1. Your `terraform apply` fails. What is your first step?

Read the complete error message and identify the failed resource.

---

### 2. Which command checks Terraform configuration?

```bash
terraform validate
```

---

### 3. Which command shows planned changes?

```bash
terraform plan
```

---

### 4. How do you check which resources Terraform manages?

```bash
terraform state list
```

---

### 5. Why should you avoid repeated `terraform apply` attempts?

Because retries do not fix the underlying problem and may complicate troubleshooting.

---

### 6. How do you verify whether the issue is in Terraform or AWS?

Compare:

- Terraform configuration
- Terraform state
- Actual AWS resources

---

### 7. What is the most common production Terraform issue?

Infrastructure drift caused by manual changes outside Terraform is one of the most common causes of unexpected plans and deployment issues.

---

# 📋 Troubleshooting Flow

```text
Read Error
      │
      ▼
Identify Resource
      │
      ▼
Validate Configuration
      │
      ▼
Review Execution Plan
      │
      ▼
Check State
      │
      ▼
Verify AWS
      │
      ▼
Check IAM
      │
      ▼
Fix Issue
      │
      ▼
terraform plan
      │
      ▼
terraform apply
```

---

# 📋 Cheat Sheet

| Task | Command |
|------|---------|
| Validate configuration | `terraform validate` |
| Review changes | `terraform plan` |
| List managed resources | `terraform state list` |
| Inspect a resource | `terraform state show <resource>` |
| Initialize project | `terraform init` |
| Apply changes | `terraform apply` |

---

# 📝 Summary

Effective Terraform troubleshooting follows a structured process rather than trial and error. By reading the error message carefully, validating the configuration, reviewing the execution plan, checking the Terraform state, verifying AWS resources, and confirming IAM permissions, you can quickly identify and resolve most issues. This disciplined approach is essential for managing production infrastructure safely and efficiently.
