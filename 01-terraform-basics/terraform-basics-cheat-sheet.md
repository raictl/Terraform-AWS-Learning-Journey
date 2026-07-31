# Terraform Basics Cheat Sheet

> A quick reference guide for Terraform Basics covering commands, workflow, state, dependency graph, execution plan, troubleshooting, and interview essentials.

---

# 🚀 Terraform Workflow

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

# 📂 Important Files

| File | Purpose |
|------|---------|
| `main.tf` | Main infrastructure configuration |
| `provider.tf` | Provider configuration |
| `versions.tf` | Terraform & provider version constraints |
| `variables.tf` | Input variable declarations |
| `terraform.tfvars` | Variable values |
| `outputs.tf` | Output values |
| `.terraform.lock.hcl` | Provider dependency lock file |
| `.terraform/` | Downloaded providers & backend metadata |
| `terraform.tfstate` | Current infrastructure state |
| `.gitignore` | Ignore local and sensitive files |

---

# ⚡ Most Used Commands

## Initialize

```bash
terraform init
```

---

## Format Code

```bash
terraform fmt
```

Format all files recursively:

```bash
terraform fmt -recursive
```

Check formatting only:

```bash
terraform fmt -check
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Preview Changes

```bash
terraform plan
```

Save execution plan:

```bash
terraform plan -out=tfplan
```

---

## Apply Changes

```bash
terraform apply
```

Apply saved plan:

```bash
terraform apply tfplan
```

Auto approve:

```bash
terraform apply -auto-approve
```

> ⚠️ Avoid `-auto-approve` in production.

---

## Destroy Infrastructure

```bash
terraform destroy
```

Auto approve:

```bash
terraform destroy -auto-approve
```

---

# 📦 Terraform State Commands

List resources:

```bash
terraform state list
```

Show resource details:

```bash
terraform state show <resource>
```

Move resource:

```bash
terraform state mv SOURCE DESTINATION
```

Remove from state:

```bash
terraform state rm <resource>
```

Download remote state:

```bash
terraform state pull
```

Upload state:

```bash
terraform state push terraform.tfstate
```

---

# 🌐 Dependency Graph

Generate graph:

```bash
terraform graph
```

Generate PNG (Graphviz installed):

```bash
terraform graph | dot -Tpng > graph.png
```

---

# 🔄 Resource Action Symbols

| Symbol | Meaning |
|---------|----------|
| `+` | Create |
| `~` | Update |
| `-` | Destroy |
| `-/+` | Destroy & Recreate |

---

# 📊 Terraform State

Default state file:

```text
terraform.tfstate
```

State contains:

- Resource IDs
- Metadata
- Attributes
- Outputs
- Dependency information

---

# 🌍 Local vs Remote State

| Local | Remote |
|--------|---------|
| Local machine | Shared backend |
| Single developer | Team collaboration |
| Manual backup | Centralized storage |
| Learning | Production |

---

# 🔗 Dependency Types

### Implicit

Terraform detects automatically.

Example:

```hcl
subnet_id = aws_subnet.public.id
```

---

### Explicit

```hcl
depends_on = [
  aws_internet_gateway.main
]
```

Use only when necessary.

---

# 🏢 Production Workflow

```text
Developer

↓

Git Commit

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

# ❌ Common Errors

| Error | Fix |
|--------|-----|
| Not initialized | `terraform init` |
| Invalid configuration | `terraform validate` |
| Formatting issue | `terraform fmt` |
| Backend changed | `terraform init -reconfigure` |
| Provider issue | `terraform init -upgrade` |
| IAM permission denied | Check IAM policy |
| State lock | Wait or investigate stale lock |
| Dependency cycle | Remove circular dependency |
| Drift detected | Review `terraform plan` |

---

# 🔍 Troubleshooting Flow

```text
Read Error
    │
    ▼
Identify Resource
    │
    ▼
Validate
    │
    ▼
Review Plan
    │
    ▼
Check State
    │
    ▼
Verify AWS
    │
    ▼
Fix
    │
    ▼
Plan Again
    │
    ▼
Apply
```

---

# ⭐ Best Practices

- Run `terraform fmt` before every commit.
- Validate before planning.
- Review every execution plan.
- Store code in Git.
- Use remote state for teams.
- Avoid manual AWS Console changes.
- Protect state files.
- Apply reviewed plans only.

---

# 🎯 Frequently Asked Interview Questions

| Question | Short Answer |
|-----------|--------------|
| What does `terraform init` do? | Initializes the working directory, downloads providers, and configures the backend. |
| What does `terraform fmt` do? | Formats Terraform code. |
| What does `terraform validate` do? | Validates configuration syntax and structure. |
| Difference between Plan & Apply? | Plan previews, Apply executes. |
| What is Terraform State? | Terraform's record of managed infrastructure. |
| Why Remote State? | Secure collaboration and centralized state management. |
| What is Drift? | Infrastructure changed outside Terraform. |
| What is `depends_on`? | Explicit dependency declaration. |
| What is `terraform graph`? | Displays the dependency graph. |

---

# 📚 Chapter 01 Summary

✅ Terraform Workflow

✅ CLI Commands

✅ Terraform State

✅ Local vs Remote State

✅ State Commands

✅ Dependency Graph

✅ Execution Plan

✅ Production Workflow

✅ Common Errors

✅ Troubleshooting

---

# 🚀 Next Chapter

**Chapter 02 – Terraform Language (HCL)**

Topics include:

- HCL Syntax
- Blocks
- Arguments
- Expressions
- Variables
- Data Types
- Locals
- Outputs
- Functions
- Meta Arguments
- Dynamic Blocks
- For Expressions
- Conditional Expressions
