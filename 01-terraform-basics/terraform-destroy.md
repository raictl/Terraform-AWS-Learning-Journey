# Terraform Destroy (`terraform destroy`)

> Learn how to safely remove Terraform-managed infrastructure and understand when, why, and how to use `terraform destroy` in real-world environments.

---

## 📖 Overview

`terraform destroy` removes all infrastructure managed by the current Terraform configuration.

Terraform compares the resources stored in the **Terraform State** with your configuration and sends delete requests to the cloud provider.

Unlike manually deleting resources from the cloud console, `terraform destroy` ensures infrastructure is removed in a controlled and predictable way.

> **⚠️ Warning:** `terraform destroy` permanently deletes Terraform-managed resources. Always review the execution plan before confirming.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand the purpose of `terraform destroy`
- Safely destroy Terraform-managed resources
- Destroy specific resources
- Use destroy in development and production
- Troubleshoot common destroy failures
- Follow industry best practices

---

# Why Do We Need `terraform destroy`?

Infrastructure is not only created—it also needs to be removed.

Common situations include:

- Cleaning up development environments
- Removing test resources
- Reducing cloud costs
- Decommissioning old infrastructure
- Preventing orphaned resources

Instead of deleting resources manually, Terraform removes everything it manages in the correct order.

---

# Internal Working

```text
Developer
      │
      ▼
terraform destroy
      │
      ▼
Read Terraform Configuration
      │
      ▼
Read terraform.tfstate
      │
      ▼
Generate Destroy Plan
      │
      ▼
Terraform Provider
      │
      ▼
AWS API
      │
      ▼
Delete Resources
      │
      ▼
Update terraform.tfstate
```

---

# Syntax

## Destroy All Resources

```bash
terraform destroy
```

---

## Skip Confirmation

```bash
terraform destroy -auto-approve
```

Useful for automation or temporary environments.

---

## Destroy a Specific Resource

```bash
terraform destroy -target=aws_s3_bucket.demo
```

> **Note:** Targeted operations should be used cautiously because they can bypass Terraform's full dependency graph.

---

# Example

Terraform Configuration:

```hcl
resource "aws_s3_bucket" "demo" {
  bucket = "terraform-learning-demo"
}
```

Run:

```bash
terraform destroy
```

Terraform Output:

```text
Terraform will perform the following actions:

- aws_s3_bucket.demo

Plan: 0 to add, 0 to change, 1 to destroy.
```

Confirmation:

```text
Do you really want to destroy all resources?

Only 'yes' will be accepted.
```

Type:

```text
yes
```

Final Output:

```text
Destroy complete!

Resources:
0 added,
0 changed,
1 destroyed.
```

---

# What Happens After Destroy?

Before:

```text
terraform.tfstate

aws_s3_bucket.demo
```

After:

```text
terraform.tfstate

(No managed resources)
```

The infrastructure is deleted and Terraform removes those resources from its state.

---

# Common Use Cases

## Clean Development Environment

```bash
terraform destroy
```

---

## Remove Temporary Test Resources

Destroy resources after completing testing.

---

## CI/CD Cleanup

```bash
terraform destroy -auto-approve
```

Common in short-lived testing environments.

---

## Decommission Infrastructure

Remove infrastructure that is no longer required to reduce operational costs.

---

# Production Workflow

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
Approval
      │
      ▼
terraform destroy
      │
      ▼
Infrastructure Removed
```

---

# Best Practices

- Never run `terraform destroy` directly in production without approval.
- Review the destroy plan carefully.
- Use remote state for team environments.
- Take backups before destroying critical infrastructure.
- Prefer environment-specific workspaces or separate state files.

---

# Common Errors

## Resource Dependency Error

```text
DependencyViolation
```

### Cause

Another resource still depends on the resource being deleted.

### Solution

Remove dependent resources first or let Terraform destroy everything together.

---

## Access Denied

```text
AccessDenied
```

### Cause

The IAM identity does not have permission to delete the resource.

### Solution

Grant the required delete permissions.

---

## State Lock Error

```text
Error acquiring the state lock
```

### Cause

Another Terraform operation is currently using the state.

### Solution

Wait for the operation to finish or investigate stale locks.

---

## Resource Already Deleted

```text
Resource not found
```

### Cause

The resource was manually deleted outside Terraform.

### Solution

Refresh or reconcile the Terraform state before proceeding.

---

# Troubleshooting Checklist

| Problem | Solution |
|----------|----------|
| Initialization error | Run `terraform init` |
| Permission denied | Check IAM permissions |
| Dependency error | Remove dependent resources |
| State lock | Wait or investigate the lock |
| Resource drift | Synchronize Terraform state |

---

# Security Considerations

- Restrict who can execute `terraform destroy`.
- Protect production environments with approval workflows.
- Use IAM roles with least privilege.
- Enable logging and auditing for infrastructure deletion.
- Backup critical data before destroying resources.

---

# Interview Questions

## 1. What is `terraform destroy`?

It removes all infrastructure managed by the current Terraform configuration.

---

## 2. Does `terraform destroy` delete every resource in the AWS account?

No.

It only deletes resources tracked in the current Terraform state.

---

## 3. What is the purpose of `-auto-approve`?

It skips the interactive confirmation prompt.

---

## 4. What does `-target` do?

It destroys a specific resource instead of the entire infrastructure.

---

## 5. Is `terraform destroy -target` recommended?

Only for special situations such as troubleshooting or emergency operations. Regular deployments should avoid targeted operations because they may leave infrastructure in an inconsistent state.

---

## 6. Can manually deleted resources affect `terraform destroy`?

Yes.

Terraform may detect drift between its state and the actual infrastructure, which can result in errors or unexpected behavior.

---

## 7. How can teams safely destroy production infrastructure?

- Review the destroy plan
- Require approvals
- Use protected branches
- Restrict IAM permissions
- Maintain backups
- Perform change management

---

# Quick Revision

- Removes Terraform-managed resources
- Uses the Terraform state
- Requires confirmation
- Supports `-auto-approve`
- Supports targeted destroy
- Updates the state after deletion

---

# Cheat Sheet

| Command | Description |
|----------|-------------|
| `terraform destroy` | Destroy all managed resources |
| `terraform destroy -auto-approve` | Destroy without confirmation |
| `terraform destroy -target=<resource>` | Destroy a specific resource |

---

# Summary

`terraform destroy` safely removes infrastructure managed by Terraform while updating the state file to reflect the changes. It is commonly used for development, testing, and infrastructure decommissioning. Because it permanently deletes resources, it should always be executed with proper review, approvals, and backups—especially in production environments.
