# Terraform State Lifecycle

> Learn how the Terraform State file is created, updated, protected, migrated, and eventually removed throughout the lifecycle of your infrastructure.

---

# 📖 Overview

The Terraform State Lifecycle describes **how the state file changes as infrastructure changes**.

Every Terraform operation interacts with the state file.

Understanding the lifecycle helps you:

- Prevent state corruption
- Troubleshoot infrastructure issues
- Work safely in teams
- Manage production infrastructure

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand the complete Terraform State lifecycle
- Explain how state changes during Terraform operations
- Understand state locking and backups
- Follow production state management practices

---

# 🔄 Terraform State Lifecycle

```text
terraform init
      │
      ▼
State Initialized
      │
      ▼
terraform apply
      │
      ▼
State Created
      │
      ▼
terraform plan
      │
      ▼
State Read
      │
      ▼
terraform apply
      │
      ▼
State Updated
      │
      ▼
Infrastructure Changes
      │
      ▼
State Updated Again
      │
      ▼
terraform destroy
      │
      ▼
Resources Deleted
      │
      ▼
State Updated
```

---

# Phase 1 – State Initialization

Command:

```bash
terraform init
```

What happens?

- Initializes the working directory
- Downloads provider plugins
- Configures the backend
- Prepares Terraform to create and manage the state

> **Note:** At this stage, the state file usually **does not exist yet** because no infrastructure has been created.

---

# Phase 2 – State Creation

Command:

```bash
terraform apply
```

Terraform:

- Creates infrastructure
- Receives resource IDs from the cloud provider
- Creates `terraform.tfstate`
- Records all managed resources

Example:

```text
Before Apply

No State File
```

↓

```text
After Apply

terraform.tfstate
```

---

# Phase 3 – State Read

Command:

```bash
terraform plan
```

Terraform:

- Reads the existing state
- Compares it with your configuration
- Checks the actual infrastructure
- Generates an execution plan

No changes are made to the infrastructure during this step.

---

# Phase 4 – State Update

Example:

Original configuration:

```hcl
instance_type = "t2.micro"
```

Updated configuration:

```hcl
instance_type = "t3.micro"
```

Run:

```bash
terraform apply
```

Terraform:

1. Updates the EC2 instance (if supported).
2. Updates the state file with the new resource attributes.

---

# Phase 5 – State Refresh

Modern Terraform automatically refreshes state during:

```bash
terraform plan
```

and

```bash
terraform apply
```

Terraform:

- Queries the cloud provider
- Detects infrastructure drift
- Updates its understanding of the infrastructure before planning changes

> **Tip:** The standalone `terraform refresh` command is deprecated.

---

# Phase 6 – State Locking

In team environments, multiple engineers may run Terraform simultaneously.

Without locking:

```text
Engineer A

Writes State
        │
        │
Engineer B

Writes State

❌ Conflict
```

With locking:

```text
Engineer A
      │
      ▼
State Locked
      │
      ▼
Update Complete
      │
      ▼
Lock Released

Engineer B
      │
      ▼
Can Continue
```

State locking prevents corruption caused by concurrent updates.

---

# Phase 7 – State Backup

Before significant updates, it's a good practice to back up the state.

Benefits:

- Recover from accidental corruption
- Restore after failed operations
- Support disaster recovery

> **Pro Tip:** Remote backends such as Amazon S3 can provide versioning, making state recovery much easier.

---

# Phase 8 – State Migration

As projects grow, teams often migrate from local state to a remote backend.

Example:

```text
Local State

↓

Amazon S3 Backend

↓

Shared Team State
```

Migration improves collaboration and enables state locking.

---

# Phase 9 – State Removal

Command:

```bash
terraform destroy
```

Terraform:

- Deletes managed resources
- Updates the state
- Removes resource entries from the state file

The infrastructure is gone, and the state reflects that no managed resources remain.

---

# Real-World Lifecycle

```text
terraform init
      │
      ▼
terraform apply
      │
      ▼
terraform.tfstate Created
      │
      ▼
terraform plan
      │
      ▼
terraform apply
      │
      ▼
terraform.tfstate Updated
      │
      ▼
terraform destroy
      │
      ▼
terraform.tfstate Updated Again
```

---

# 🌍 Production Example

A DevOps team deploys infrastructure to AWS.

1. Initialize Terraform.
2. Deploy resources.
3. Store state in a remote backend.
4. Lock the state during updates.
5. Review plans before applying.
6. Keep backups through backend versioning.
7. Destroy temporary environments when no longer needed.

This lifecycle is repeated throughout the application's lifetime.

---

# ⭐ Best Practices

- Use remote state for team environments.
- Enable state locking.
- Enable backend versioning.
- Never edit the state manually.
- Review execution plans before applying.
- Keep infrastructure changes within Terraform whenever possible.

---

# ❌ Common Mistakes

- Using local state for production teams.
- Disabling state locking.
- Manually deleting the state file.
- Sharing state files through email or chat.
- Making infrastructure changes outside Terraform.

---

# 🔧 Troubleshooting

| Problem | Solution |
|----------|----------|
| State missing | Restore from backup or backend |
| State locked | Wait or investigate stale locks |
| Infrastructure drift | Review with `terraform plan` |
| Corrupted state | Recover from versioned backup |

---

# 🎤 Interview Questions

### 1. What is the Terraform State Lifecycle?

It describes how the state file is created, read, updated, protected, migrated, and maintained throughout the lifecycle of managed infrastructure.

---

### 2. When is the state file created?

Typically after the first successful `terraform apply`.

---

### 3. Why is state locking important?

It prevents multiple users from modifying the same state simultaneously, reducing the risk of corruption.

---

### 4. Why should state backups be maintained?

To recover from accidental deletion, corruption, or failed operations.

---

### 5. What happens to the state after `terraform destroy`?

Terraform removes the deleted resources from the state so it accurately reflects the remaining managed infrastructure.

---

# 📋 Cheat Sheet

| Phase | Description |
|--------|-------------|
| Initialize | `terraform init` prepares the backend |
| Create | `terraform apply` creates state |
| Read | `terraform plan` reads state |
| Update | State changes after apply |
| Refresh | Terraform synchronizes state during plan/apply |
| Lock | Prevents concurrent modifications |
| Backup | Protects against data loss |
| Migrate | Move state to a remote backend |
| Destroy | Remove resources and update state |

---

# 📝 Summary

The Terraform State Lifecycle covers every stage of state management—from initialization and creation to updates, locking, backups, migration, and cleanup. Understanding this lifecycle is essential for building reliable, collaborative, and production-ready Infrastructure as Code workflows.
