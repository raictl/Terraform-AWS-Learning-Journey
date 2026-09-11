# 🚀 Project 15 — Terraform Workspaces

## 📖 Overview

Terraform Workspaces allow you to use the **same Terraform configuration** while maintaining **separate state files** for different environments or deployments.

In this project, we use Terraform Workspaces to create separate files for:

* `default`
* `dev`
* `staging`
* `production`

Each workspace maintains its own Terraform state.

---

## 🎯 Objective

The goal of this project is to understand:

* What Terraform Workspaces are
* How to create and manage workspaces
* How Terraform maintains separate state for each workspace
* How to use `terraform.workspace`
* When Workspaces are useful
* When Workspaces should **not** be used

---

## 🏗️ Project Architecture

```text
                    Terraform Configuration
                            │
                            │
                  ┌─────────┴─────────┐
                  │                   │
             Same main.tf       terraform.workspace
                  │                   │
       ┌──────────┼──────────┬────────┼──────────┐
       │          │          │        │          │
    default      dev      staging  production   qa
       │          │          │        │          │
       ▼          ▼          ▼        ▼          ▼
 workspace-   workspace-  workspace- workspace- workspace-
 default.txt    dev.txt   staging.txt production.txt qa.txt
```

---

# 📝 Step-by-Step Implementation

## Step 1 — Create the Project Directory

```powershell
cd 01-terraform-basics\projects

mkdir 15-terraform-workspaces

cd 15-terraform-workspaces
```

---

## Step 2 — Create `main.tf`

```hcl
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

locals {
  environment_message = {
    default    = "This is the default environment."
    dev        = "This is the development environment."
    staging    = "This is the staging environment."
    production = "This is the production environment."
  }
}

resource "local_file" "workspace_demo" {
  filename = "workspace-${terraform.workspace}.txt"

  content = <<-EOT
    Terraform Workspace: ${terraform.workspace}

    ${local.environment_message[terraform.workspace]}
  EOT
}
```

> **Note:** If using the `qa` workspace, the configuration can be extended with a `qa` message. The important concept is that `terraform.workspace` automatically returns the currently selected workspace.

---

## Step 3 — Initialize Terraform

```powershell
terraform init
```

This downloads the required Local provider.

---

## Step 4 — Validate Configuration

```powershell
terraform validate
```

Expected:

```text
Success! The configuration is valid.
```

---

# 🌎 Working with Workspaces

## Step 5 — List Workspaces

```powershell
terraform workspace list
```

Initially:

```text
* default
```

The `*` indicates the currently selected workspace.

---

## Step 6 — Apply in the Default Workspace

```powershell
terraform apply
```

Type:

```text
yes
```

Terraform creates:

```text
workspace-default.txt
```

---

## Step 7 — Create Development Workspace

```powershell
terraform workspace new dev
```

Terraform automatically switches to `dev`.

Verify:

```powershell
terraform workspace show
```

Expected:

```text
dev
```

---

## Step 8 — Apply in Development

```powershell
terraform apply
```

Terraform creates:

```text
workspace-dev.txt
```

---

## Step 9 — Create Staging Workspace

```powershell
terraform workspace new staging
```

Then:

```powershell
terraform apply
```

Terraform creates:

```text
workspace-staging.txt
```

---

## Step 10 — Create Production Workspace

```powershell
terraform workspace new production
```

Then:

```powershell
terraform apply
```

Terraform creates:

```text
workspace-production.txt
```

---

## Step 11 — Create QA Workspace

```powershell
terraform workspace new qa
```

Then:

```powershell
terraform apply
```

Terraform creates:

```text
workspace-qa.txt
```

---

# 🔄 Switching Between Workspaces

List all workspaces:

```powershell
terraform workspace list
```

Switch to development:

```powershell
terraform workspace select dev
```

Check the current workspace:

```powershell
terraform workspace show
```

Switch to production:

```powershell
terraform workspace select production
```

Check again:

```powershell
terraform workspace show
```

---

# 📂 Workspace State

Terraform maintains separate state for different workspaces.

For local state, workspace-specific state can be stored under:

```text
.terraform/
└── terraform.tfstate.d/
    ├── dev/
    ├── staging/
    ├── production/
    └── qa/
```

The important concept is:

```text
Same Configuration
       │
       ├── dev state
       ├── staging state
       ├── production state
       └── qa state
```

Therefore, changing the workspace changes which state Terraform is working with.

---

# 🔍 Important Terraform Commands

| Command                          | Purpose                        |
| -------------------------------- | ------------------------------ |
| `terraform workspace list`       | List all workspaces            |
| `terraform workspace show`       | Show current workspace         |
| `terraform workspace new dev`    | Create and switch to workspace |
| `terraform workspace select dev` | Switch workspace               |
| `terraform workspace delete dev` | Delete a workspace             |
| `terraform plan`                 | Preview changes                |
| `terraform apply`                | Apply changes                  |

---

# 🧩 `terraform.workspace`

Terraform provides a built-in expression:

```hcl
terraform.workspace
```

It returns the name of the currently selected workspace.

For example:

```text
dev
```

when the `dev` workspace is active.

We use it in this project:

```hcl
filename = "workspace-${terraform.workspace}.txt"
```

If the current workspace is `dev`:

```text
workspace-dev.txt
```

If the current workspace is `production`:

```text
workspace-production.txt
```

---

# 🧪 Verification

Run:

```powershell
terraform workspace list
```

Expected:

```text
  default
  dev
  staging
  production
* qa
```

Then:

```powershell
Get-ChildItem workspace-*.txt
```

Expected files:

```text
workspace-default.txt
workspace-dev.txt
workspace-staging.txt
workspace-production.txt
workspace-qa.txt
```

You can inspect a file:

```powershell
Get-Content workspace-qa.txt
```

Expected:

```text
Terraform Workspace: qa
```

---

# ⚠️ When NOT to Use Terraform Workspaces

Workspaces are useful, but they are **not always the best environment-management solution**.

Avoid relying heavily on Workspaces when:

### 1. Environments are significantly different

For example:

```text
Development → small infrastructure
Production  → highly available infrastructure
```

Separate Terraform configurations or environment directories may be better.

### 2. You need strong environment isolation

Workspaces are not a security boundary.

### 3. Infrastructure becomes complex

For larger production environments, a structure such as:

```text
terraform/
├── modules/
└── environments/
    ├── dev/
    ├── staging/
    └── production/
```

is often easier to understand and maintain.

---

# 💼 Real-World DevOps Perspective

A common misconception is:

> "I should always use Terraform Workspaces for dev, staging and production."

That is not necessarily correct.

Workspaces are useful when:

```text
Same infrastructure design
        +
Small environment differences
        =
Terraform Workspaces
```

For substantially different environments:

```text
Different infrastructure
        +
Different configurations
        =
Separate environment configurations
```

---

# 🎯 Interview Questions & Answers

### Q1. What is a Terraform Workspace?

**Answer:**

A Terraform Workspace allows the same Terraform configuration to manage different instances of infrastructure using separate state files.

---

### Q2. What is the default Terraform Workspace?

**Answer:**

The default workspace is called:

```text
default
```

---

### Q3. How do you list Terraform Workspaces?

```powershell
terraform workspace list
```

---

### Q4. How do you create a workspace?

```powershell
terraform workspace new dev
```

---

### Q5. How do you switch between workspaces?

```powershell
terraform workspace select dev
```

---

### Q6. How do you check the current workspace?

```powershell
terraform workspace show
```

---

### Q7. How can Terraform configuration know which workspace is active?

Using:

```hcl
terraform.workspace
```

---

### Q8. Do different Terraform Workspaces have separate state?

**Answer:**

Yes. Each workspace maintains its own state.

---

### Q9. Are Terraform Workspaces a security boundary?

**Answer:**

No. Workspaces provide separate state instances but should not be treated as a security boundary.

---

### Q10. Should Workspaces always be used for dev, staging and production?

**Answer:**

No. They can work well when environments share essentially the same configuration, but separate environment configurations are often more appropriate for complex or significantly different environments.

---


# 💡 Best Practices

* Use meaningful workspace names.
* Always verify the current workspace before production changes.
* Don't treat Workspaces as a security boundary.
* Don't use Workspaces simply because they exist.
* Use separate environment configurations when environments become significantly different.
* Never commit Terraform state files to Git.
* Add Terraform-generated files to `.gitignore`.
* Keep `.terraform.lock.hcl` under version control.
* Use remote state and proper locking for team environments.

