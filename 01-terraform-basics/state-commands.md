# Terraform State Commands

> Learn how to inspect, manage, and modify Terraform State safely using the `terraform state` command family.

---

# 📖 Overview

The `terraform state` command is used to inspect and manage the Terraform State file without directly editing `terraform.tfstate`.

These commands help you:

- View managed resources
- Inspect resource details
- Move resources within the state
- Remove resources from the state
- Download or upload remote state
- Replace provider references

> ⚠️ **Warning:** These commands modify Terraform's understanding of infrastructure. Use them carefully, especially in production.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- List Terraform-managed resources
- Inspect individual resources
- Move resources in state
- Remove resources from state
- Work with remote state
- Understand production use cases

---

# Terraform State Commands

| Command | Purpose |
|----------|---------|
| `terraform state list` | List all resources in state |
| `terraform state show` | Display details of a resource |
| `terraform state mv` | Move a resource within the state |
| `terraform state rm` | Remove a resource from the state |
| `terraform state pull` | Download remote state |
| `terraform state push` | Upload a state file |
| `terraform state replace-provider` | Update provider references |

---

# 1️⃣ terraform state list

Lists all resources currently tracked by Terraform.

### Syntax

```bash
terraform state list
```

### Example Output

```text
aws_instance.web

aws_security_group.web

aws_s3_bucket.logs
```

### Use Cases

- Verify managed resources
- Debug Terraform state
- Prepare for refactoring

---

# 2️⃣ terraform state show

Displays detailed information about a specific resource.

### Syntax

```bash
terraform state show aws_instance.web
```

### Example Output

```text
id = i-0123456789abcdef
instance_type = t3.micro
availability_zone = ap-south-1a
```

### Use Cases

- Verify resource attributes
- Inspect IDs
- Troubleshoot configuration

---

# 3️⃣ terraform state mv

Moves a resource from one state address to another.

### Syntax

```bash
terraform state mv SOURCE DESTINATION
```

### Example

```bash
terraform state mv \
aws_instance.web \
module.compute.aws_instance.web
```

### Common Use Cases

- Refactoring into modules
- Renaming resources
- Reorganizing configurations

> 💡 **Pro Tip:** `terraform state mv` updates only the state. It does **not** recreate the infrastructure.

---

# 4️⃣ terraform state rm

Removes a resource from the Terraform state **without deleting the actual infrastructure**.

### Syntax

```bash
terraform state rm aws_instance.web
```

### What Happens?

Before:

```text
Terraform State

↓

EC2 Instance
```

After:

```text
Terraform State

(No EC2)

AWS

EC2 Still Exists
```

Terraform no longer manages the resource.

### Use Cases

- Hand over management to another tool
- Prepare for importing the resource again
- Resolve certain state issues

> ⚠️ **Warning:** The resource still exists in the cloud. Terraform simply stops tracking it.

---

# 5️⃣ terraform state pull

Downloads the current state from the configured remote backend.

### Syntax

```bash
terraform state pull
```

### Use Cases

- Inspect remote state
- Create backups
- Troubleshoot state issues

---

# 6️⃣ terraform state push

Uploads a local state file to the configured backend.

### Syntax

```bash
terraform state push terraform.tfstate
```

### Use Cases

- State recovery
- State migration
- Restore from backup

> ⚠️ **Warning:** Avoid pushing outdated or incorrect state files, as they can overwrite the current backend state.

---

# 7️⃣ terraform state replace-provider

Updates provider references stored in the state.

### Example

```bash
terraform state replace-provider \
hashicorp/aws \
company/aws
```

### Common Use Cases

- Provider namespace changes
- Provider migrations
- Upgrading provider sources

---

# Real-World Scenario

Suppose you have:

```hcl
resource "aws_instance" "web"
```

You later refactor your project:

```hcl
module "compute" {

}
```

Without `terraform state mv`:

Terraform thinks:

```text
Old Resource

↓

Delete

↓

Create New Resource
```

Using:

```bash
terraform state mv
```

Terraform understands the resource has only changed its address—not that it needs to be recreated.

---

# Internal Working

```text
Developer
      │
      ▼
terraform state Command
      │
      ▼
Read State File
      │
      ▼
Modify Metadata
      │
      ▼
Save Updated State
```

No direct infrastructure changes occur for most `terraform state` subcommands.

---

# Best Practices

- Always back up the state before making changes.
- Prefer Terraform configuration changes over manual state edits.
- Use `terraform state mv` during refactoring.
- Avoid editing `terraform.tfstate` manually.
- Verify changes with `terraform plan` after state operations.

---

# Common Mistakes

### Editing `terraform.tfstate`

May corrupt the state.

---

### Using `state rm` Accidentally

Terraform loses management of the resource.

---

### Incorrect `state push`

Can overwrite the correct state with outdated information.

---

### Forgetting to Verify

Always run:

```bash
terraform plan
```

after state modifications.

---

# Troubleshooting

| Problem | Solution |
|----------|----------|
| Wrong resource moved | Restore from backup and retry |
| State corruption | Recover from backend version history or backup |
| Resource missing from state | Import it again if appropriate |
| Incorrect provider reference | Use `replace-provider` carefully |

---

# Security Considerations

- Restrict access to state commands.
- Encrypt remote state storage.
- Maintain backend version history.
- Audit production state changes.
- Back up state before performing maintenance.

---

# Interview Questions

### 1. What does `terraform state list` do?

Lists all resources tracked by Terraform.

---

### 2. Does `terraform state rm` delete cloud resources?

No.

It removes the resource **only from the Terraform State**.

---

### 3. Why is `terraform state mv` useful?

It lets you reorganize or refactor Terraform code without recreating existing infrastructure.

---

### 4. What is `terraform state show` used for?

To display detailed information about a resource stored in the state.

---

### 5. Why should you back up the state before using state commands?

Because incorrect state operations can make Terraform lose track of managed infrastructure.

---

### 6. Does `terraform state mv` modify infrastructure?

No.

It updates only the Terraform State.

---

### 7. When would you use `terraform state pull`?

To download and inspect the latest state from a remote backend.

---

# 📋 Cheat Sheet

| Command | Purpose |
|----------|---------|
| `terraform state list` | List managed resources |
| `terraform state show` | Show resource details |
| `terraform state mv` | Move a resource in state |
| `terraform state rm` | Remove resource from state |
| `terraform state pull` | Download remote state |
| `terraform state push` | Upload local state |
| `terraform state replace-provider` | Replace provider references |

---

# 📝 Summary

The `terraform state` command family provides safe tools for inspecting and managing Terraform State without manually editing the state file. These commands are essential for infrastructure refactoring, state recovery, provider migrations, and production troubleshooting. Understanding when and how to use them is a key skill for DevOps and Platform Engineers working with Terraform.
