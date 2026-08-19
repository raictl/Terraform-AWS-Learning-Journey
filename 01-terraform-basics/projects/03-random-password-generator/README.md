# 🔐 Project 03 — Random Password Generator

## 📖 Overview

In this project, I used the HashiCorp Random provider to generate a random password and exposed the generated value through a sensitive Terraform output.

The project introduces an important real-world Infrastructure as Code concept: handling sensitive information safely.

---

## 🏗️ Project Architecture

Terraform Configuration
        │
        ▼
 Random Provider
        │
        ▼
random_password.password
        │
        ▼
 Generated Password
        │
        ▼
Sensitive Terraform Output

---

## 📁 Project Structure

03-random-password-generator/
│
├── README.md
├── main.tf
├── outputs.tf
├── .gitignore
└── .terraform.lock.hcl
```

The `.terraform/` directory and Terraform state files are excluded from Git.

---

## 📝 Implementation

### Random Password Resource

The project uses the HashiCorp Random provider and the `random_password` resource.

resource "random_password" "password" {
  length           = 16
  special          = true
  upper            = true
  numeric          = true
  override_special = "!@#$%"
}

The resource generates a random password based on the specified configuration.

---

## 🔐 Sensitive Output

The generated password is exposed using a sensitive Terraform output:

```hcl
output "generated_password" {
  description = "Randomly generated password"
  value       = random_password.password.result
  sensitive   = true
}
```

The important configuration is:

```hcl
sensitive = true
```

This prevents Terraform from casually displaying the output in normal command-line output.

---

## ⚠️ Sensitive Data and Terraform State

Marking an output as sensitive does not mean the value is encrypted everywhere.

Sensitive values may still be stored in Terraform state.

Therefore, Terraform state must be protected and should not be committed to a public Git repository.

The project uses `.gitignore` rules such as:

```gitignore
*.tfstate
*.tfstate.*
```

---

## 🔧 Terraform Commands Used

### Initialize

terraform init

### Format

terraform fmt

### Validate

terraform validate

### Plan

terraform plan

### Apply

terraform apply

### Display outputs

terraform output

### Retrieve a sensitive output explicitly

terraform output -raw generated_password

> Do not publish the returned password.

### List resources

terraform state list

### Destroy resources

terraform destroy

---

## 🧹 Cleanup

Destroy the resource after completing the experiment:

```bash
terraform destroy
```

Verify:

```bash
terraform state list
```

There should be no Terraform-managed resources remaining.

---

## 💡 Security Best Practices

* Never hardcode passwords in Terraform configuration.
* Mark sensitive outputs using `sensitive = true`.
* Never commit Terraform state to a public repository.
* Never publish generated passwords in README files.
* Never include secrets in screenshots.
* Protect Terraform state in real-world environments.
* Use appropriate secret-management solutions for production applications.
* Review `.gitignore` before committing Terraform projects.

---

## 📚 Official Documentation

* [Terraform Sensitive Data](https://developer.hashicorp.com/terraform/language/state/sensitive-data)
* [Terraform Outputs](https://developer.hashicorp.com/terraform/language/values/outputs)
* [Random Password Resource](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)
* [Terraform State](https://developer.hashicorp.com/terraform/language/state)

---
