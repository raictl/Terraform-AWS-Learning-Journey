# 🚀 Project 06 — Local File with Terraform Variables

## 📖 Overview

In this project, I enhanced the Local File Generator from Project 05 by introducing Terraform input variables.

Instead of hardcoding project information directly inside the Terraform resource, the values are provided through Terraform variables and `terraform.tfvars`.

This makes the configuration more reusable and easier to manage across different environments.

---


## 🏗️ Project Architecture

```text
                 Input Values
                      │
                      ▼
               terraform.tfvars
                      │
                      ▼
               Terraform Variables
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
   project_name  environment    owner
          │           │           │
          └───────────┼───────────┘
                      ▼
                    main.tf
                      │
                      ▼
             local_file.project_info
                      │
                      ▼
       terraform-project-info.txt

---

## 📝 Terraform Configuration

The Local provider is configured in `main.tf`:

```hcl
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}
```

---

## 📄 Local File Resource

The local file is managed using:

```hcl
resource "local_file" "project_info" {
  filename = "${path.module}/terraform-project-info.txt"

  content = <<-EOT
    Terraform Project Information
    =============================

    Project Name: ${var.project_name}
    Environment: ${var.environment}
    Owner: ${var.owner}
  EOT
}
```

The resource uses variables instead of hardcoded values.

---

## 🔢 Terraform Variables

The variables are defined in `variables.tf`:

```hcl
variable "project_name" {
  description = "Name of the Terraform project"
  type        = string
  default     = "Terraform Learning Journey"
}

variable "environment" {
  description = "Environment where the project is running"
  type        = string
  default     = "development"
}

variable "owner" {
  description = "Person or team responsible for the project"
  type        = string
  default     = "Terraform Student"
}
```

Each variable has:

* Name
* Description
* Type
* Default value

---

## 📋 Variable Values

The project uses `terraform.tfvars`:

```hcl
project_name = "Terraform Portfolio"
environment  = "production"
owner        = "DevOps Student"
```

Terraform automatically loads `terraform.tfvars`.

These values override the defaults defined in `variables.tf`.

---

## 🔄 Default Values vs Overrides

For example, the variable has this default:

```hcl
default = "development"
```

But `terraform.tfvars` contains:

```hcl
environment = "production"
```

Terraform uses:

```text
production
```

instead of:

```text
development
```

This demonstrates variable overriding.

---

## 🖥️ Command-Line Variables

Variables can also be supplied through the command line:

```bash
terraform plan -var="environment=staging"
```

This allows temporary testing without changing the Terraform configuration.

---

## 📤 Terraform Outputs

The configured values are exposed through outputs:

```hcl
output "project_name" {
  description = "Configured project name"
  value       = var.project_name
}

output "environment" {
  description = "Configured environment"
  value       = var.environment
}

output "owner" {
  description = "Configured project owner"
  value       = var.owner
}
```

View outputs:

```bash
terraform output
```

---

## 🔧 Terraform Commands Used

### Initialize

```bash
terraform init
```

### Format

```bash
terraform fmt
```

### Validate

```bash
terraform validate
```

### Plan

```bash
terraform plan
```

### Apply

```bash
terraform apply
```

### View outputs

```bash
terraform output
```

### List resources

```bash
terraform state list
```

### Inspect state

```bash
terraform show
```

### Destroy

```bash
terraform destroy
```

---

## 🔍 Verification

After running:

```bash
terraform apply
```

Terraform creates:

```text
terraform-project-info.txt
```

The file should contain values provided through Terraform variables.

Example:

```text
Terraform Project Information
=============================

Project Name: Terraform Portfolio
Environment: production
Owner: DevOps Student
```

Verify the resource:

```bash
terraform state list
```

Expected:

```text
local_file.project_info
```

---

## 🧪 Variable Change Test

Change the value in `terraform.tfvars`:

```hcl
environment = "staging"
```

Then run:

```bash
terraform plan
```

Terraform should detect that the resource needs to change.

Apply:

```bash
terraform apply
```

The generated file should now contain:

```text
Environment: staging
```

---

## 🧪 Idempotency Test

Run:

```bash
terraform plan
```

again without making any additional changes.

Terraform should report no changes.

This demonstrates that Terraform maintains the desired state.

---

## 🧪 Command-Line Override Test

Run:

```bash
terraform plan -var="project_name=My-Terraform-Lab"
```

Terraform should use:

```text
My-Terraform-Lab
```

for the project name during the plan.

---

## 🔐 Security Considerations

The current `terraform.tfvars` contains only non-sensitive demonstration values.

In real-world projects, variable files may contain:

* Passwords
* API keys
* Tokens
* Credentials
* Other sensitive values

Sensitive values should not be committed to Git.

For example:

```gitignore
*.tfvars
*.tfvars.json

---

## ❗ Common Errors

### Variable not declared

Example:

```text
Reference to undeclared input variable
```

Make sure the variable exists in `variables.tf`.

### Variable value not provided

If a variable has no default and no value is supplied, Terraform will ask for the value or report an error depending on the command/context.

Provide a value through:

```text
terraform.tfvars
```

or:

```bash
terraform plan -var="environment=staging"
```

### Invalid variable type

For example, if a variable expects:

```hcl
type = string
```

provide a string value.

### Changes are not appearing

Run:

```bash
terraform plan
```

and confirm that the variable value is being loaded from the expected source.

---

## 💡 Best Practices

* Use meaningful variable names.
* Add descriptions to variables.
* Define explicit variable types.
* Avoid hardcoding reusable values.
* Separate configuration from variable values.
* Use `terraform.tfvars` for environment-specific values.
* Never commit secrets.
* Review `terraform plan` before applying changes.
* Use `terraform fmt`.
* Run `terraform validate`.
* Keep Terraform state out of Git.

---

## 🎤 Interview Questions

### 1. What is a Terraform input variable?

An input variable allows values to be passed into a Terraform configuration without hardcoding them.

### 2. How do you define a Terraform variable?

Using a `variable` block:

```hcl
variable "environment" {
  type = string
}
```

### 3. How do you reference a variable?

Using:

```hcl
var.environment
```

### 4. What is `terraform.tfvars`?

It is a variable definition file used to provide values for Terraform input variables.

### 5. What is a variable default?

A default value is used when no explicit value is supplied for a variable.

### 6. Can a variable be passed through the command line?

Yes:

```bash
terraform plan -var="environment=staging"
```

### 7. Why are variables important?

They make Terraform configurations reusable across different environments and use cases.

### 8. Should secrets be stored in `terraform.tfvars`?

They can technically be supplied there, but sensitive values should not be committed to Git. Secure secret-management approaches should be used in real projects.

---

## 📚 Official Documentation

* [Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)
* [Variable Definition Files](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-files)
* [Variable Precedence](https://developer.hashicorp.com/terraform/language/values/variables#precedence)
* [Terraform Types and Values](https://developer.hashicorp.com/terraform/language/expressions/types)

---
