# Terraform Apply (`terraform apply`)

> Learn how Terraform applies an execution plan to create, update, or destroy infrastructure.

---

## 📖 Overview

`terraform apply` is the command that **executes** the infrastructure changes defined in your Terraform configuration. It compares your desired configuration with the current state, generates (or uses) an execution plan, and applies the required changes to your cloud infrastructure.

Unlike `terraform plan`, which only previews changes, `terraform apply` performs real operations against the cloud provider.

---

## 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand the purpose of `terraform apply`
- Apply Terraform configurations safely
- Apply a saved execution plan
- Understand how the Terraform state is updated
- Follow production deployment best practices
- Troubleshoot common deployment issues

---

# Why Do We Need `terraform apply`?

Writing Terraform code alone does not create infrastructure.

Example:

```hcl
resource "aws_s3_bucket" "demo" {
  bucket = "my-demo-bucket"
}
```

The above configuration only describes the **desired state**.

The infrastructure is created only after running:

```bash
terraform apply
```

---

# Internal Working

```text
Developer
      │
      ▼
terraform apply
      │
      ▼
Read Terraform Configuration
      │
      ▼
Read terraform.tfstate
      │
      ▼
Generate / Use Execution Plan
      │
      ▼
Terraform Provider
      │
      ▼
AWS API
      │
      ▼
Create / Update / Delete Resources
      │
      ▼
Update terraform.tfstate
```

---

# Syntax

### Apply Current Configuration

```bash
terraform apply
```

---

### Apply Saved Plan

```bash
terraform apply tfplan
```

---

### Skip Confirmation

```bash
terraform apply -auto-approve
```

> Useful in CI/CD pipelines after appropriate review and approval.

---

# Example

## Terraform Configuration

```hcl
resource "aws_s3_bucket" "demo" {
  bucket = "terraform-learning-demo"
}
```

Run:

```bash
terraform apply
```

Terraform asks for confirmation:

```text
Do you want to perform these actions?

Terraform will perform the actions described above.

Only 'yes' will be accepted to approve.

Enter a value:
```

Type:

```text
yes
```

Expected Output:

```text
Apply complete!

Resources:
1 added,
0 changed,
0 destroyed.
```

---

# What Happens After Apply?

Terraform updates the state file.

Before:

```text
terraform.tfstate

(No resources)
```

After:

```text
terraform.tfstate

aws_s3_bucket.demo
```

Terraform now knows that it manages this resource.

---

# Common Use Cases

## Deploy Infrastructure

```bash
terraform apply
```

---

## Apply Reviewed Plan

```bash
terraform plan -out=tfplan

terraform apply tfplan
```

---

## Automated Deployment

```bash
terraform apply -auto-approve
```

Commonly used in:

- GitHub Actions
- Jenkins
- GitLab CI
- Azure DevOps

---

# Production Workflow

```text
Git Push
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
Peer Review / Approval
     │
     ▼
terraform apply
     │
     ▼
Infrastructure Updated
```

---

# Best Practices

- Always review `terraform plan` before applying.
- Use saved plans (`terraform apply tfplan`) for production.
- Protect the Terraform state file.
- Use remote backends for team collaboration.
- Avoid `-auto-approve` for manual production deployments.
- Use least-privilege IAM permissions.

---

# Common Errors

## Terraform Not Initialized

```text
Error: Terraform has not been initialized.
```

### Solution

```bash
terraform init
```

---

## Invalid Configuration

```text
Error: Invalid configuration
```

### Solution

```bash
terraform validate
```

---

## Access Denied

```text
AccessDenied
```

### Cause

Insufficient IAM permissions.

---

## Bucket Already Exists

```text
BucketAlreadyExists
```

### Cause

S3 bucket names are globally unique.

Use a unique bucket name.

---

## State Lock Error

```text
Error acquiring the state lock
```

### Cause

Another Terraform operation is using the state.

Wait for it to finish or investigate the lock before unlocking.

---

# Troubleshooting Checklist

| Problem | Solution |
|----------|----------|
| Initialization error | `terraform init` |
| Validation error | `terraform validate` |
| Authentication issue | Configure AWS credentials |
| Resource already exists | Use a unique name |
| State locked | Wait or investigate the lock |

---

# Security Considerations

- Never hardcode cloud credentials.
- Store Terraform state securely.
- Review plans before applying.
- Limit production access using IAM roles.
- Never commit sensitive files to Git.

---

# Interview Questions

### 1. What is `terraform apply`?

It applies the infrastructure changes required to match the Terraform configuration.

---

### 2. What is the difference between `terraform plan` and `terraform apply`?

| terraform plan | terraform apply |
|----------------|-----------------|
| Preview changes | Execute changes |
| No infrastructure changes | Modifies infrastructure |
| Safe to review | Performs real operations |

---

### 3. What does `terraform apply tfplan` do?

It applies a previously saved and reviewed execution plan.

---

### 4. Why is `terraform apply -auto-approve` used?

It skips manual confirmation and is commonly used in CI/CD pipelines.

---

### 5. What happens to the state file after `terraform apply`?

Terraform updates `terraform.tfstate` so it accurately reflects the current infrastructure.

---

### 6. Can `terraform apply` delete resources?

Yes. If the execution plan contains destroy actions, Terraform will delete the corresponding resources.

---

### 7. Is `terraform apply` reversible?

No. Terraform does not provide an automatic rollback. To reverse changes, you must modify the configuration and apply again or restore from backups where appropriate.

---

# Quick Revision

- Executes infrastructure changes.
- Creates, updates, or deletes resources.
- Updates `terraform.tfstate`.
- Requires confirmation unless `-auto-approve` is used.
- Best practice: review `terraform plan` before applying.

---

# Cheat Sheet

| Command | Description |
|----------|-------------|
| `terraform apply` | Apply infrastructure changes |
| `terraform apply tfplan` | Apply a saved execution plan |
| `terraform apply -auto-approve` | Skip confirmation prompt |

---

# Summary

`terraform apply` is the command that transforms Terraform configuration into real infrastructure. It is the execution phase of the Terraform workflow and should always be used carefully. In production environments, the recommended practice is to review an execution plan, obtain approval, and then apply the saved plan to ensure predictable and controlled infrastructure changes.
