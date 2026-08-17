# 🚀 Project 01 — Terraform - Random provider

## 📖 Overview

This is the first project in my Terraform learning journey.

The purpose of this project is to understand the fundamental Terraform workflow by creating a simple resource using the HashiCorp Random provider.

This project does not require AWS infrastructure, making it suitable for learning Terraform fundamentals without cloud infrastructure costs.

---

## 🎯 Objective

The objectives of this project are to:

* Understand the basics of Terraform.
* Understand Terraform providers.
* Understand Terraform resources.
* Understand Terraform state at a beginner level.

## 📝 Implementation

The project uses the HashiCorp Random provider.

Example resource:

```hcl
resource "random_pet" "name" {
  length = 2
}
```

This resource demonstrates the basic Terraform resource syntax.

---

## 🔧 Terraform Commands Used

### Initialize Terraform

terraform init

### Format configuration

terraform fmt

### Validate configuration

terraform validate

### Create an execution plan

terraform plan

### Apply configuration

terraform apply

### Inspect resources

terraform show

### List Terraform-managed resources

terraform state list

### Destroy resources

terraform destroy

---

## ❗ Common Errors

### Error: Terraform command not found

Verify that Terraform is installed:

terraform version

If the command is not recognized, install Terraform and ensure it is available in your system PATH.

### Error: Provider installation problem

Run:

terraform init

again.

### Error: Invalid Terraform configuration

Run:

terraform fmt
terraform validate
```

and inspect the reported error.

---

## 💡 Best Practices

* Run `terraform fmt` before committing Terraform code.
* Run `terraform validate` before creating infrastructure.
* Review `terraform plan` before running `terraform apply`.
* Do not commit Terraform state files to a public repository.
* Keep `.terraform/` out of Git.
* Use meaningful Git commit messages.
* Destroy temporary infrastructure when it is no longer required.
* Keep Terraform projects small and focused while learning.

---

## 🎤 Interview Questions

### 1. What is Terraform?

Terraform is an Infrastructure as Code tool used to define and manage infrastructure using configuration files.

### 2. What is a Terraform provider?

A provider is a plugin that enables Terraform to communicate with external platforms and APIs.

### 3. What is a Terraform resource?

A resource represents an infrastructure object or service managed by Terraform.

### 4. What does `terraform init` do?

It initializes the Terraform working directory and installs required providers and modules.

### 5. What is the purpose of `terraform plan`?

It previews the changes Terraform intends to make without applying them.

### 6. What is Terraform state?

Terraform state stores information about resources managed by Terraform.

---

## 📚 Official Documentation

* [Terraform CLI](https://developer.hashicorp.com/terraform/cli)
* [Terraform Language](https://developer.hashicorp.com/terraform/language)
* [Terraform Providers](https://developer.hashicorp.com/terraform/language/providers)
* [Random Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs)

