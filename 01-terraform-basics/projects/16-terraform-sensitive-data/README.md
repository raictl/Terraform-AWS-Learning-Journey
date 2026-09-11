# 🔐 Project 16 — Terraform Sensitive Data & Secrets

## 📖 Overview

This project demonstrates how Terraform handles sensitive information such as usernames and passwords.

The project focuses on:

* Sensitive input variables
* Sensitive outputs
* Environment variables using `TF_VAR_*`
* `terraform.tfvars`
* `.gitignore`
* Sensitive values in Terraform CLI output
* Sensitive values in Terraform state
* Secret exposure through generated files
* Basic Terraform secret-management best practices

> ⚠️ This project uses dummy credentials for learning purposes only.

---

## 🎯 Objective

Learn how to safely handle sensitive values in Terraform and understand the limitations of Terraform's `sensitive` feature.

The most important lesson is:

> **`sensitive = true` hides values from normal CLI output; it does not encrypt the value or remove it from Terraform state.**

---


---

## 📁 Project Structure

```text
16-terraform-sensitive-data/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

Generated during execution:

```text
secret-demo.txt
terraform.tfstate
```

These generated files should not be committed to Git.

---

# 🏗️ Architecture

```text
                 Terraform Variables
                        │
            ┌───────────┴───────────┐
            │                       │
     terraform.tfvars         TF_VAR_password
            │                       │
            └───────────┬───────────┘
                        │
                        ▼
                  var.password
                        │
                        ▼
                local_file resource
                        │
                        ▼
                secret-demo.txt
```

Terraform also stores resource information in:

```text
terraform.tfstate
```

Therefore, the state file must be treated as sensitive.

---

# 📝 Step-by-Step Implementation

## Step 1 — Create Project Directory

```text
01-terraform-basics/projects/16-terraform-sensitive-data
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

resource "local_file" "secret_demo" {
  filename = "secret-demo.txt"

  content = <<-EOT
    Application: ${var.application_name}
    Username: ${var.username}
    Password: ${var.password}
  EOT
}
```

The resource uses the Terraform variables instead of hardcoding the values directly.

---

## Step 3 — Create `variables.tf`

```hcl
variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "username" {
  description = "Application username"
  type        = string
}

variable "password" {
  description = "Application password"
  type        = string
  sensitive   = true
}
```

The important configuration is:

```hcl
sensitive = true
```

This tells Terraform that the variable contains sensitive information.

---

## Step 4 — Create `outputs.tf`

```hcl
output "application_name" {
  description = "Application name"
  value       = var.application_name
}

output "username" {
  description = "Application username"
  value       = var.username
}

output "password" {
  description = "Application password"
  value       = var.password
  sensitive   = true
}
```

The password output is also marked sensitive.

---

## Step 5 — Create `terraform.tfvars`

For this learning project:

```hcl
application_name = "demo-app"
username         = "admin"
password         = "DemoPassword123!"
```

⚠️ Never commit real production credentials to this file.

---

## Step 6 — Create `.gitignore`

```gitignore
.terraform/
*.tfstate
*.tfstate.*
terraform.tfvars
secret-demo.txt
```

This prevents sensitive files and Terraform state from accidentally being committed.

---

# 🚀 Terraform Commands

## Initialize

```cmd
terraform init
```

## Validate

```cmd
terraform validate
```

Expected:

```text
Success! The configuration is valid.
```

## Create Plan

```cmd
terraform plan
```

Terraform should mask sensitive values in appropriate CLI output.

---

## Apply Configuration

```cmd
terraform apply
```

Enter:

```text
yes
```

Terraform creates:

```text
secret-demo.txt
```

Verify:

```cmd
type secret-demo.txt
```

The generated file contains the application information and password.

---

# 🔎 Sensitive Outputs

Run:

```cmd
terraform output
```

The password should be displayed as a sensitive value rather than normally exposing it.

To explicitly reveal the value:

```cmd
terraform output -raw password
```

> ⚠️ Use `-raw` carefully because it intentionally reveals the sensitive value.

---

# 🔐 Environment Variables

Terraform supports environment variables using the naming convention:

```text
TF_VAR_<variable_name>
```

For example:

```text
TF_VAR_password
```

automatically maps to:

```hcl
var.password
```

### Windows CMD

Set the variable:

```cmd
set TF_VAR_password=AnotherDummyPassword123!
```

Verify:

```cmd
echo %TF_VAR_password%
```

Terraform can then use:

```hcl
var.password
```

without changing `main.tf`.

Remove the variable:

```cmd
set TF_VAR_password=
```

---

# 🧠 Important Security Lesson

## `sensitive = true` Does NOT Mean Encryption

This is one of the most important Terraform interview concepts.

For example:

```hcl
variable "password" {
  type      = string
  sensitive = true
}
```

does not mean Terraform encrypts the password everywhere.

It primarily tells Terraform to treat the value as sensitive when displaying information to the user.

Sensitive information can still exist in:

```text
terraform.tfstate
```

Therefore:

> **Terraform state must be protected like sensitive data.**

---

# 📦 Terraform State Security

Terraform state may contain sensitive information depending on the resources and configuration.

Therefore:

* Do not commit state files to Git.
* Restrict access to state.
* Protect state storage.
* Use encryption where supported.
* Avoid exposing state contents in logs.
* Carefully control CI/CD permissions.

`.gitignore` helps prevent accidental commits, but it is **not a security mechanism or encryption mechanism**.

---

# 🔑 Secret Management Best Practices

### ❌ Avoid

```hcl
password = "MyRealProductionPassword"
```

inside Terraform configuration.

### ❌ Avoid

Committing:

```text
terraform.tfvars
terraform.tfstate
```

when they contain sensitive information.

### ✅ Prefer

Environment variables:

```text
TF_VAR_password
```

for appropriate local/CI/CD scenarios.

### ✅ For AWS workloads

Use dedicated secret-management solutions such as:

* AWS Secrets Manager
* AWS Systems Manager Parameter Store
* CI/CD secret stores
* IAM roles where appropriate

These will be covered more deeply in later AWS-focused projects.

---

# 💼 Real-World DevOps Scenario

A CI/CD pipeline might inject a secret as an environment variable:

```text
CI/CD Secret Store
       │
       ▼
TF_VAR_password
       │
       ▼
Terraform
       │
       ▼
Infrastructure
```

The secret does not need to be written directly into the Git repository.

However, the Terraform state still needs appropriate protection.

---

# ❗ Common Errors & Solutions

### Error: Required variable not provided

Example:

```text
No value for required variable
```

Solution:

Provide the variable through:

```text
terraform.tfvars
```

or:

```text
TF_VAR_variable_name
```

---

### Password appears as sensitive

If Terraform displays:

```text
(sensitive value)
```

this is expected behavior.

Terraform is intentionally hiding the value from normal output.

---

### Password exists in state

This is also possible and is **not automatically an error**.

Remember:

```text
sensitive ≠ encrypted
```

Protect the Terraform state accordingly.

---

### `terraform.tfvars` appears in Git

Check `.gitignore`:

```gitignore
terraform.tfvars
```

If Git was already tracking the file, `.gitignore` alone will not remove it from tracking.

---

# 🎤 Interview Questions

### 1. What does `sensitive = true` do?

It tells Terraform to treat a value as sensitive and prevents normal CLI output from exposing it.

---

### 2. Does `sensitive = true` encrypt the secret?

**No.**

It controls display behavior; it does not provide complete secret encryption.

---

### 3. Can sensitive values exist in Terraform state?

**Yes.**

Terraform state can contain sensitive information and must therefore be protected.

---

### 4. What is `TF_VAR_*`?

It is Terraform's environment-variable naming convention for supplying input variables.

Example:

```text
TF_VAR_password
```

maps to:

```hcl
var.password
```

---

### 5. Why should `terraform.tfvars` sometimes be added to `.gitignore`?

Because it may contain passwords, API keys, tokens, or other sensitive values.

---

### 6. Is `.gitignore` a security mechanism?

**No.**

It helps prevent accidental Git tracking, but it does not encrypt or secure the file.

---

### 7. Why should Terraform state be protected?

Because state can contain infrastructure information and potentially sensitive values.

---

### 8. How should production secrets be managed?

Use dedicated secret-management systems and appropriate IAM/access controls rather than hardcoding secrets in Terraform configuration.

---

# 💡 Best Practices

* Never hardcode production credentials.
* Mark sensitive variables and outputs as `sensitive`.
* Do not commit secrets to Git.
* Do not commit sensitive Terraform state.
* Protect Terraform state with strong access controls.
* Be careful when using `terraform output -raw`.
* Use environment variables appropriately.
* Use dedicated secret-management systems for production.
* Prefer short-lived credentials and IAM roles where possible.
* Never paste real credentials into learning repositories.

---


