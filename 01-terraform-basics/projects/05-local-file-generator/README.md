# 📄 Project 05 — Local File Generator

## 📖 Overview

In this project, I used the HashiCorp Local provider and the `local_file` resource to create and manage a local text file using Terraform.

This project introduces an important Terraform concept: Infrastructure as Code can manage resources beyond cloud infrastructure.

---
## 🏗️ Project Architecture

```text
Terraform Configuration
        │
        ▼
   Local Provider
        │
        ▼
local_file.project_info
        │
        ▼
terraform-project-info.txt
        │
        ▼
   Terraform State
```

---

## 📁 Project Structure

```text
05-local-file-generator/
│
├── README.md
├── main.tf
├── terraform-project-info.txt
├── .gitignore
└── .terraform.lock.hcl
```

## 📝 Implementation

The project uses the HashiCorp Local provider:

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

The file is managed using:

```hcl
resource "local_file" "project_info" {
  filename = "${path.module}/terraform-project-info.txt"

  content = <<-EOT
    Terraform Project Information
    =============================

    Project Name: Terraform Learning Journey
    Environment: Development
    Owner: Terraform Student
  EOT
}
```

---

## 📍 Understanding `path.module`

The project uses:

```hcl
filename = "${path.module}/terraform-project-info.txt"
```

`path.module` represents the filesystem path of the current Terraform module.

Using it instead of a machine-specific absolute path makes the project portable.

Avoid hardcoding paths such as:

```text
C:\Users\YourName\Desktop\
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

Terraform should create:

```text
terraform-project-info.txt
```

Verify the Terraform resource:

```bash
terraform state list
```

Expected:

```text
local_file.project_info
```

---

## 🧪 Idempotency Test

After applying the configuration, run:

```bash
terraform plan
```

Terraform should report that there are no changes when the file and configuration match.

This demonstrates Terraform's idempotent behavior.

---

## 🔄 Configuration Change Test

Change:

```text
Environment: Development
```

to:

```text
Environment: Production
```

inside `main.tf`.

Then run:

```bash
terraform fmt
terraform validate
terraform plan
```

Terraform should detect the changed file content.

Apply the change:

```bash
terraform apply
```

The generated file should now contain:

```text
Environment: Production
```

---

## ⚠️ Configuration Drift Test

Manually modify the generated file and change:

```text
Owner: Terraform Student
```

to:

```text
Owner: Someone Else
```

Then run:

```bash
terraform plan
```

Terraform should detect that the managed resource differs from the desired configuration.

Running:

```bash
terraform apply
```

restores the file according to the Terraform configuration.

This demonstrates the concept of configuration drift.

---

## 🧹 Cleanup

Destroy the Terraform-managed file:

```bash
terraform destroy
```

Confirm with:

```text
yes
```

Terraform should remove:

```text
terraform-project-info.txt
```

---


## 🎤 Interview Questions

### 1. What is the Local provider?

The Local provider allows Terraform to manage local filesystem resources.

### 2. What is `local_file`?

`local_file` is a Terraform resource used to create and manage files on the local filesystem.

### 3. What is `path.module`?

`path.module` represents the filesystem path of the current Terraform module.

### 4. What is a heredoc?

A heredoc is a Terraform syntax for defining multi-line strings.

### 5. What is configuration drift?

Configuration drift occurs when the real resource differs from the desired Terraform configuration.

### 6. Why should absolute local paths be avoided?

Absolute paths are machine-specific and make Terraform projects less portable.

### 7. What happens during `terraform destroy`?

Terraform removes the resources managed by the configuration.

---

## 📚 Official Documentation

* [Terraform Local Provider](https://registry.terraform.io/providers/hashicorp/local/latest/docs)
* [local_file Resource](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)
* [Terraform Expressions](https://developer.hashicorp.com/terraform/language/expressions)
* [Terraform String Templates](https://developer.hashicorp.com/terraform/language/expressions/strings)
* [Terraform Paths](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

---

