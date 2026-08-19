# 🚀 Project 04 — Multiple Random Resources

## 📖 Overview


In this project, I created and managed multiple Terraform resources within a single configuration using the HashiCorp Random provider.

The project demonstrates how Terraform manages multiple independent resources, tracks them in state, exposes their values through outputs, and detects configuration changes.

---
## 🏗️ Project Architecture

```text
                    Terraform
                       │
                       ▼
                 Random Provider
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
   Application     Environment       Team
        │              │              │
        └──────────────┼──────────────┘
                       │
                       ▼
                    Project
                       │
                       ▼
                 Terraform Outputs
```

The resources in this project are independent because they do not reference each other.

---

## 📁 Project Structure

```text
04-multiple-random-resources/
│
├── README.md
├── main.tf
├── outputs.tf
├── .gitignore
└── .terraform.lock.hcl
```

---

## 📝 Implementation

The project creates four independent `random_pet` resources.

### Application

```hcl
resource "random_pet" "application" {
  length    = 2
  separator = "-"
}
```

### Environment

```hcl
resource "random_pet" "environment" {
  length    = 2
  separator = "-"
}
```

### Team

```hcl
resource "random_pet" "team" {
  length    = 2
  separator = "-"
}
```

### Project

```hcl
resource "random_pet" "project" {
  length    = 2
  separator = "-"
}
```

---

## 📤 Terraform Outputs

The generated resource values are exposed through outputs.

Example:

```hcl
output "application_name" {
  description = "Generated application name"
  value       = random_pet.application.id
}
```

Additional outputs are created for:

* Environment
* Team
* Project

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

### View a specific output

```bash
terraform output application_name
```

### List resources

```bash
terraform state list
```

### Inspect state

```bash
terraform show
```

### Destroy resources

```bash
terraform destroy
```

---

## 🔍 Verification

After applying the configuration:

```bash
terraform apply
```

Terraform should create four resources.

Expected resource addresses:

```text
random_pet.application
random_pet.environment
random_pet.project
random_pet.team
```

The exact order may vary.

Verify them with:

```bash
terraform state list
```

---

## 🧪 Idempotency Test

After applying the configuration, run:

```bash
terraform plan
```

If there are no configuration changes, Terraform should report that no changes are required.

This demonstrates Terraform's idempotent behavior.

---

## 🔄 Configuration Change Test

The initial team resource uses:

```hcl
length = 2
```

Changing it to:

```hcl
length = 3
```

allows Terraform to detect a change to the team resource.

Run:

```bash
terraform fmt
terraform validate
terraform plan
```

Then apply:

```bash
terraform apply
```

The test demonstrates that Terraform can identify the affected resource instead of treating the entire configuration as a completely new infrastructure deployment.

---

## 🧹 Cleanup

Destroy all resources after completing the project:

```bash
terraform destroy
```

Verify that no resources remain:

```bash
terraform state list
```

---

## 🎤 Interview Questions

### 1. What is a resource address?

A resource address uniquely identifies a resource in Terraform.

Example:

```text
random_pet.application
```

### 2. What is idempotency?

Idempotency means repeatedly applying the same desired configuration should not continuously create additional changes when the infrastructure already matches that configuration.

---

## 📚 Official Documentation

* [Terraform Resources](https://developer.hashicorp.com/terraform/language/resources/syntax)
* [Terraform Resource Behavior](https://developer.hashicorp.com/terraform/language/resources/behavior)
* [Terraform State Commands](https://developer.hashicorp.com/terraform/cli/commands/state)
* [Terraform Plan](https://developer.hashicorp.com/terraform/cli/commands/plan)
* [Terraform Apply](https://developer.hashicorp.com/terraform/cli/commands/apply)

