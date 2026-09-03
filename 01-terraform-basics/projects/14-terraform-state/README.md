# 🚀 Project 14 — Terraform State

> **Part of the [Terraform & AWS Learning Journey](https://github.com/raictl/Terraform-AWS-Learning-Journey)**

![Terraform](https://img.shields.io/badge/Terraform-1.x-7B42BC?logo=terraform)
![Provider](https://img.shields.io/badge/Provider-Local-blue)
![Level](https://img.shields.io/badge/Level-Intermediate-orange)
![Topic](https://img.shields.io/badge/Topic-Terraform%20State-green)

---

## 📖 Overview

Terraform State is one of the most important concepts in Terraform.

Terraform uses a **state file** to keep track of the infrastructure resources it manages. State allows Terraform to understand the relationship between the configuration written in `.tf` files and the real infrastructure.

In this project, I explored Terraform State using the `local` provider and practiced important state management operations including:

* Inspecting Terraform State
* Listing resources in state
* Inspecting individual resources
* Understanding resource addresses
* Detecting configuration drift
* Moving resources in state
* Removing resources from state
* Importing existing resources
* Understanding state locking
* Understanding local vs remote state
* Learning AWS S3 remote state architecture
* Applying Terraform State best practices

---

14-terraform-state/
│
├── main.tf
├── example.txt
├── terraform.tfstate
├── .terraform.lock.hcl
└── .terraform/
```

### Important

The following files/directories should **not be committed to GitHub**:

```text
terraform.tfstate
terraform.tfstate.*
.terraform/
```

The Terraform dependency lock file should generally be committed:

```text
.terraform.lock.hcl
```

---

# 🏗️ Terraform Configuration

The project uses the Terraform `local` provider.

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

resource "local_file" "application" {
  filename = "example.txt"
  content  = "Hello from Terraform State!"
}
```

The configuration creates a local file:

```text
example.txt
```

Terraform then records the managed resource in its state.

---

# 🚀 Getting Started

## Step 1 — Initialize Terraform

```powershell
terraform init
```

Terraform downloads the required provider and initializes the working directory.

---

## Step 2 — Validate Configuration

```powershell
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

## Step 3 — Create the Resource

```powershell
terraform apply
```

Review the execution plan and enter:

```text
yes
```

Terraform creates:

```text
example.txt
```

---

# 🔍 Working with Terraform State

## 1. List Resources

Use:

```powershell
terraform state list
```

Example:

```text
local_file.example
```

This shows the resources currently tracked by Terraform State.

---

## 2. Inspect a Resource

Use:

```powershell
terraform state show local_file.example
```

This displays the attributes Terraform has stored for the resource.

---

## 3. Understand Resource Addresses

Terraform identifies resources using resource addresses.

Example:

```text
local_file.example
```

The structure is:

```text
resource_type.resource_name
```

Therefore:

```text
local_file
```

is the resource type and:

```text
application
```

is the resource name.

---

# 🔄 Terraform State vs Configuration vs Infrastructure

Terraform works with three important components:

```text
             Terraform Configuration
                    (*.tf)
                       │
                       ▼
                 Terraform State
              (terraform.tfstate)
                       │
                       ▼
             Real Infrastructure
```

### Terraform Configuration

Defines the desired infrastructure.

```text
What do I want?
```

### Terraform State

Records what Terraform knows about the infrastructure.

```text
What does Terraform manage?
```

### Real Infrastructure

The actual resource exists outside Terraform.

```text
What actually exists?
```

Terraform compares these to determine what actions are required.

---

# ⚠️ State Drift

State drift occurs when the actual infrastructure changes outside Terraform.

For example:

```text
Terraform Configuration
        │
        ▼
Terraform State
        │
        ▼
Actual Resource
```

If someone manually changes the resource, the actual infrastructure can become different from what Terraform expects.

Terraform can detect differences during planning/refresh operations.

Modern Terraform workflows normally refresh state during `plan` and `apply`.

For an explicit refresh-only plan:

```powershell
terraform plan -refresh-only
```

---

# 🔧 Important Terraform State Commands

| Command                        | Purpose                                               |
| ------------------------------ | ----------------------------------------------------- |
| `terraform state list`         | List resources in state                               |
| `terraform state show`         | Inspect a resource                                    |
| `terraform state mv`           | Move/rename a resource in state                       |
| `terraform state rm`           | Remove a resource from state                          |
| `terraform import`             | Import an existing resource                           |
| `terraform plan`               | Preview infrastructure changes                        |
| `terraform plan -refresh-only` | Refresh state without proposing configuration changes |

---

# 🔀 Hands-on: `terraform state mv`

`terraform state mv` is useful when changing a resource address without wanting Terraform to recreate the actual resource.

For example, changing:

```text
local_file.example
```

to:

```text
local_file.application
```

First update the Terraform configuration.

Then run:

```powershell
terraform state mv local_file.example local_file.application
```

Verify:

```powershell
terraform state list
```

Expected:

```text
local_file.application
```

Then:

```powershell
terraform plan
```

Ideally:

```text
No changes.
```

### Real-world use case

This is useful during Terraform refactoring when resource names or module structures change.

---

# 🗑️ Hands-on: `terraform state rm`

The `terraform state rm` command removes a resource from Terraform State.

Example:

```powershell
terraform state rm local_file.application
```

Then:

```powershell
terraform state list
```

The resource should no longer appear in the state.

### Important

`terraform state rm` normally removes the resource **from Terraform management**, but does not destroy the real resource.

For example:

```text
Terraform State
      │
      X
      │
      ▼
Actual Resource
      │
      ✓
```

The resource can still exist outside Terraform.

---

# 📥 Importing an Existing Resource

Terraform Import allows an existing resource to become managed by Terraform.

Example:

```powershell
terraform import local_file.application example.txt
```

Then verify:

```powershell
terraform state list
```

Expected:

```text
local_file.application
```

Finally:

```powershell
terraform plan
```

The goal is to have Terraform understand the existing resource without unnecessarily recreating it.

### Important

`terraform import`:

* Does not create the existing resource.
* Adds an existing resource to Terraform State.
* Requires a matching Terraform resource configuration.
* Should be followed by `terraform plan`.

---

# 🔐 Terraform State Locking

State locking prevents multiple Terraform operations from modifying the same state simultaneously.

Without locking, two engineers could potentially run Terraform against the same state at the same time.

Example:

```text
Engineer A ─────┐
                │
                ▼
           Terraform State
                ▲
                │
Engineer B ─────┘
```

Locking helps ensure that only one state-changing operation occurs at a time.

---

# ☁️ Local State vs Remote State

## Local State

By default, Terraform can store state locally:

```text
terraform.tfstate
```

This works well for:

* Learning
* Small experiments
* Personal development

But it is not ideal for a team environment.

---

## Remote State

Production teams commonly store state remotely.

For AWS environments, an S3 backend is a common approach.

Example:

```hcl
terraform {
  backend "s3" {
    bucket       = "my-terraform-state-bucket"
    key          = "project-14/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
```

The state is then stored centrally:

```text
Developer
    │
    ▼
Terraform
    │
    ▼
AWS S3
    │
    ├── Terraform State
    │
    └── State Lock
```

> Note: Modern Terraform supports native S3 state locking with `use_lockfile = true`. Older tutorials may use DynamoDB for locking; DynamoDB is a legacy approach rather than a requirement for the current S3 backend.

---

# 🏢 Real-World Terraform State Architecture

A typical DevOps workflow can look like:

```text
              ┌─────────────────┐
              │     GitHub      │
              │ Terraform Code  │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │   CI/CD Pipeline│
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │    Terraform    │
              └────────┬────────┘
                       │
             ┌─────────┴─────────┐
             ▼                   ▼
      ┌─────────────┐     ┌──────────────┐
      │ AWS S3      │     │ AWS Resources│
      │ Remote State│     │              │
      └─────────────┘     └──────────────┘
```

This architecture allows teams to:

* Share Terraform State
* Maintain a central source of state
* Prevent concurrent state modifications
* Integrate Terraform with CI/CD
* Protect state using AWS security controls

---

# 🔒 Terraform State Security Best Practices

Terraform State can contain sensitive information.

Therefore:

### ❌ Never commit state to Git

Do not commit:

```text
terraform.tfstate
terraform.tfstate.*
```

### ❌ Never manually edit the state file

Use Terraform commands instead:

```powershell
terraform state list
terraform state show
terraform state mv
terraform state rm
```

### ✅ Use remote state for teams

Use a centralized backend such as S3.

### ✅ Enable encryption

Protect state data at rest.

### ✅ Enable S3 versioning

Versioning helps recover previous state versions.

### ✅ Enable Block Public Access

The Terraform State bucket should not be publicly accessible.

### ✅ Use least-privilege IAM

Only authorized users and CI/CD systems should access the state.

### ✅ Enable locking

Prevent simultaneous state modifications.

---
# 🧪 Verification

Run:

```powershell
terraform fmt
terraform validate
terraform plan
terraform state list
```

A healthy project should have:

```text
Terraform configuration → Valid
Terraform state         → Accessible
Terraform plan          → Expected
Managed resources       → Correct
```

---

# 🎓 Interview Questions

### Beginner

**1. What is Terraform State?**

Terraform State is Terraform's record of the resources it manages and their known attributes.

**2. Why does Terraform need State?**

It allows Terraform to track resources and determine what changes are required.

**3. Where is local Terraform State stored?**

By default:

```text
terraform.tfstate
```

---

### Intermediate

**4. What is state drift?**

Drift occurs when the actual infrastructure differs from what Terraform configuration/state expects.

**5. What does `terraform state mv` do?**

It changes a resource's address in Terraform State without necessarily recreating the real resource.

**6. What does `terraform state rm` do?**

It removes a resource from Terraform State without normally destroying the real resource.

**7. What does `terraform import` do?**

It adds an existing resource to Terraform State so Terraform can manage it.

---

### Advanced

**8. Why should Terraform State not be stored in Git?**

State can contain sensitive information and can change frequently, causing security and collaboration problems.

**9. Why is remote state important in a team?**

It gives multiple engineers and automation systems access to a shared source of Terraform State.

**10. What is state locking?**

State locking prevents concurrent Terraform operations from modifying the same state simultaneously.

**11. How would you secure Terraform State in AWS?**

A strong approach includes:

* Private S3 bucket
* Encryption
* Versioning
* Block Public Access
* Least-privilege IAM
* State locking
* Restricted access

---

# 📊 Project Skills Demonstrated

This project demonstrates practical knowledge of:

```text
Terraform
   │
   ├── State Management
   ├── Resource Addresses
   ├── State Inspection
   ├── State Drift
   ├── State Refactoring
   ├── Resource Import
   ├── State Locking
   ├── Remote State
   ├── AWS S3 Backend
   └── State Security
```

---

# 🧹 Cleanup

For the local provider resource, destroy the infrastructure when the project is no longer needed:

```powershell
terraform destroy
```

Confirm:

```text
yes
```

Then verify the working directory and Git status.

> If you are completing the state-management exercise involving `terraform state rm`, make sure the state is restored/imported as intended before final cleanup and committing the project.

---

# 💡 Key Takeaways

The most important lessons from this project are:

1. **Terraform State is critical to Terraform's operation.**
2. **State connects Terraform configuration with managed infrastructure.**
3. **Never manually edit the state file.**
4. **Never commit Terraform State to GitHub.**
5. **Use `terraform state` commands for controlled state operations.**
6. **`terraform state mv` is useful for safe Terraform refactoring.**
7. **`terraform state rm` removes Terraform management, not normally the real resource.**
8. **`terraform import` brings existing infrastructure under Terraform management.**
9. **Remote State is important for team collaboration.**
10. **State must be secured because it can contain sensitive information.**

---

# 📚 Official Documentation

* [Terraform State](https://developer.hashicorp.com/terraform/language/state)
* [Terraform State CLI](https://developer.hashicorp.com/terraform/cli/commands/state)
* [Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
* [Terraform Backends](https://developer.hashicorp.com/terraform/language/backend)
* [S3 Backend](https://developer.hashicorp.com/terraform/language/backend/s3)
* [Terraform Best Practices](https://developer.hashicorp.com/terraform/language)

---

