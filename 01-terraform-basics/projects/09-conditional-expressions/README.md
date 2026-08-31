# 🚀 Project 09 — Terraform Conditional Expressions

## 📖 Overview

In this project, I introduced Terraform conditional expressions and used them to create environment-dependent configuration.

The project demonstrates how Terraform can make decisions based on input variables and generate different values for development, staging, and production environments.

---

## 🎯 Objective

The objectives of this project are to:

* Understand Terraform conditional expressions.
* Learn the `condition ? true_value : false_value` syntax.
* Understand boolean expressions.
* Use comparison operators.
* Create environment-dependent configuration.
* Use local values for calculated configuration.
* Implement variable validation.
* Understand nested conditional expressions.
* Learn when conditional expressions can become difficult to maintain.

---

## 📁 Project Structure

```text
09-conditional-expressions/
│
├── README.md
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── .gitignore
└── .terraform.lock.hcl
```

## 🔀 Conditional Expression

Terraform supports conditional expressions using:

```hcl
condition ? true_value : false_value
```

Example:

```hcl
var.environment == "production" ? "HIGH" : "LOW"
```

If the environment is:

```text
production
```

the result is:

```text
HIGH
```

Otherwise:

```text
LOW
```

---

## 🧠 Environment-Based Configuration

The project uses conditional expressions to determine:

```text
development → LOW
staging     → MEDIUM
production  → HIGH
```

It also calculates:

```text
Backup Required
Monitoring Level
Production Status
Access Level
```

---

## 📄 Local Values

The project uses Terraform local values:

```hcl
locals {
  environment_level = var.environment == "production" ? "HIGH" : var.environment == "staging" ? "MEDIUM" : "LOW"

  backup_required = var.environment == "production" ? "YES" : "NO"

  monitoring_level = var.environment == "production" ? "24x7" : "BUSINESS_HOURS"
}
```

Local values allow calculated values to be reused within the configuration.

---

## 🛡️ Variable Validation

The environment variable is restricted to:

```text
development
staging
production
```

Validation is implemented using:

```hcl
validation {
  condition = contains(
    ["development", "staging", "production"],
    var.environment
  )

  error_message = "Environment must be development, staging, or production."
}
```

This prevents invalid environment values from being accepted.

---

## 🔎 Example — Development

Input:

```hcl
environment = "development"
```

Calculated values:

```text
Environment Level: LOW
Backup Required: NO
Monitoring Level: BUSINESS_HOURS
Is Production: false
```

---

## 🔎 Example — Production

Input:

```hcl
environment = "production"
```

Calculated values:

```text
Environment Level: HIGH
Backup Required: YES
Monitoring Level: 24x7
Is Production: true
```

---

## 🔎 Example — Staging

Input:

```hcl
environment = "staging"
```

Calculated values:

```text
Environment Level: MEDIUM
Backup Required: NO
Monitoring Level: BUSINESS_HOURS
Is Production: false
```

---

## 🧪 Nested Conditional

The project uses a nested conditional for environment level:

```hcl
environment_level = var.environment == "production" ? "HIGH" : var.environment == "staging" ? "MEDIUM" : "LOW"
```

The logic is:

```text
production → HIGH
staging    → MEDIUM
everything else → LOW
```

Variable validation ensures that only supported environments are accepted.

---

## 🧠 Boolean Expressions

A comparison such as:

```hcl
var.environment == "production"
```

returns either:

```text
true
```

or:

```text
false
```

The project exposes this through:

```hcl
output "is_production" {
  value = var.environment == "production"
}
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

### Destroy

```bash
terraform destroy
```

---

## 🔍 Verification

After:

```bash
terraform apply
```

Terraform creates:

```text
environment-report.txt
```

For production, the file contains values similar to:

```text
Terraform Environment Report
=============================

Project Name: Terraform Portfolio
Environment: production

Environment Level: HIGH
Backup Required: YES
Monitoring Level: 24x7
```

---

## 🧪 Experiments

### Change environment to staging

```hcl
environment = "staging"
```

Run:

```bash
terraform plan
```

Terraform should calculate:

```text
Environment Level: MEDIUM
```

---

### Change environment to production

```hcl
environment = "production"
```

Run:

```bash
terraform plan
```

Terraform should calculate:

```text
Environment Level: HIGH
Backup Required: YES
Monitoring Level: 24x7
```

---

### Test invalid input

Try:

```hcl
environment = "testing"
```

Run:

```bash
terraform plan
```

Terraform should reject the value because validation allows only:

```text
development
staging
production
```

---

## 🌎 Real-World Use Case

Conditional expressions can be used to customize infrastructure based on environment.

For example:

```text
Development
→ Low monitoring
→ Smaller infrastructure
→ Fewer backups

Staging
→ Medium monitoring
→ Testing configuration

Production
→ High monitoring
→ Required backups
→ Production-grade configuration
```

This allows one Terraform configuration to behave differently based on input variables.

---

### Overusing nested conditionals

Large nested conditionals become difficult to read and maintain.

For many environment mappings, a map may be cleaner.

---

## 💡 Best Practices

* Keep simple conditional expressions readable.
* Use variable validation for restricted values.
* Use local values for reusable calculated expressions.
* Avoid deeply nested conditionals.
* Use maps when handling many fixed key-value relationships.
* Use meaningful names for local values.
* Always run `terraform plan` before applying.
* Test both valid and invalid input values.
* Keep environment-specific logic explicit.

---

## 🎤 Interview Questions

### 1. What is a Terraform conditional expression?

It selects one of two values depending on whether a condition is true or false.

### 2. Why is validation important?

It prevents invalid configuration from being used.

---

## 📚 Official Documentation

* [Terraform Conditional Expressions](https://developer.hashicorp.com/terraform/language/expressions/conditionals)
* [Terraform Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
* [Terraform Variable Validation](https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules)
* [Terraform Operators](https://developer.hashicorp.com/terraform/language/expressions/operators)

---
