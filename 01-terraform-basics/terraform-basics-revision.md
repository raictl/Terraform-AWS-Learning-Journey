# Terraform Basics – Revision Notes

> A quick revision guide covering the most important Terraform Basics concepts for interviews and day-to-day DevOps work.

---

# 📖 Chapter Overview

In this chapter, you learned:

- Terraform Workflow
- Terraform CLI Commands
- Terraform State
- Dependency Graph
- Execution Plan
- Production Workflow
- Common Errors
- Troubleshooting

---

# Terraform Workflow

```text
Write Code
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
terraform apply
    │
    ▼
Infrastructure Created
```

---

# Important Terraform Commands

| Command | Purpose |
|----------|---------|
| `terraform init` | Initialize project |
| `terraform fmt` | Format Terraform code |
| `terraform validate` | Validate configuration |
| `terraform plan` | Preview infrastructure changes |
| `terraform apply` | Apply infrastructure changes |
| `terraform destroy` | Remove managed infrastructure |

---

# Terraform State

Remember:

- Default file:

```text
terraform.tfstate
```

Terraform State stores:

- Resource IDs
- Resource attributes
- Outputs
- Metadata
- Resource mappings

Without State:

❌ Terraform cannot track infrastructure.

---

# Local vs Remote State

| Local State | Remote State |
|--------------|--------------|
| Local machine | Shared backend |
| Personal projects | Team environments |
| Manual backup | Centralized management |
| Not recommended for production | Recommended for production |

---

# Dependency Types

### Implicit Dependency

Terraform detects automatically.

Example:

```hcl
subnet_id = aws_subnet.public.id
```

---

### Explicit Dependency

```hcl
depends_on = [
  aws_security_group.web
]
```

Use only when Terraform cannot infer the dependency.

---

# Execution Plan Symbols

| Symbol | Meaning |
|---------|----------|
| `+` | Create |
| `~` | Update |
| `-` | Destroy |
| `-/+` | Destroy and recreate |

---

# Production Workflow

```text
Developer

↓

Git

↓

Pull Request

↓

Code Review

↓

terraform plan

↓

Approval

↓

terraform apply

↓

Production
```

---

# Common Errors

| Error | Solution |
|--------|----------|
| Not initialized | `terraform init` |
| Invalid configuration | `terraform validate` |
| Formatting issue | `terraform fmt` |
| Backend changed | `terraform init -reconfigure` |
| Provider issue | `terraform init -upgrade` |
| IAM error | Check permissions |
| State lock | Wait or investigate stale lock |
| Drift | Review with `terraform plan` |

---

# Troubleshooting Steps

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
Fix Issue
```

---

# Best Practices

- Always run `terraform fmt`
- Validate before planning
- Review every execution plan
- Use remote state in production
- Protect state files
- Avoid manual AWS Console changes
- Store Terraform code in Git
- Use Pull Requests for reviews

---

# Important Files

```text
provider.tf
versions.tf
variables.tf
terraform.tfvars
main.tf
outputs.tf
terraform.tfstate
terraform.lock.hcl
.gitignore
```

---

# Frequently Used Commands

```bash
terraform init

terraform fmt

terraform validate

terraform plan

terraform plan -out=tfplan

terraform apply

terraform apply tfplan

terraform destroy

terraform state list

terraform state show <resource>

terraform graph
```

---

# Top Interview Questions

### What does `terraform init` do?

Initializes the working directory, downloads providers, configures the backend, and creates the lock file.

---

### Why is Terraform State important?

It maps Terraform configuration to real infrastructure and allows Terraform to track managed resources.

---

### Difference between Plan and Apply?

`terraform plan` previews changes.

`terraform apply` executes them.

---

### Why use Remote State?

To enable secure collaboration, centralized management, and production-ready workflows.

---

### What is Infrastructure Drift?

When the actual infrastructure differs from the Terraform configuration or state.

---

### What is `depends_on`?

An explicit dependency used when Terraform cannot automatically determine the correct resource order.

---

### What is an Execution Plan?

A preview of infrastructure changes before they are applied.

---

# One-Minute Interview Revision

✅ Terraform is Declarative IaC.

✅ `terraform init` initializes the project.

✅ `terraform fmt` formats code.

✅ `terraform validate` checks syntax and configuration.

✅ `terraform plan` previews changes.

✅ `terraform apply` creates or updates infrastructure.

✅ `terraform destroy` removes managed resources.

✅ Terraform State tracks infrastructure.

✅ Remote State is recommended for production.

✅ Review plans before applying.

---

# 📝 Summary

Terraform Basics provides the foundation for Infrastructure as Code. Mastering the CLI workflow, understanding Terraform State, interpreting execution plans, managing dependencies, and following production best practices prepares you to confidently build, manage, and troubleshoot cloud infrastructure in real-world DevOps environments.
