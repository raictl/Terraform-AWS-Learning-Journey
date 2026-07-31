# Terraform Basics: `terraform validate`

## 📚 Introduction

`terraform validate` checks whether your Terraform configuration is **syntactically correct and internally consistent**.

It verifies that your Terraform code is valid **before** creating an execution plan or provisioning infrastructure.

> **Rule:** Always run `terraform validate` after `terraform fmt` and before `terraform plan`.

---

# Learning Objectives

After completing this lesson, you will be able to:

- Understand the purpose of `terraform validate`
- Validate Terraform configuration files
- Identify syntax and configuration errors
- Troubleshoot validation failures
- Use `terraform validate` in CI/CD pipelines

---

# Syntax

```bash
terraform validate
```

---

# What does `terraform validate` do?

It checks:

- Terraform syntax
- Resource block structure
- Variable references
- Output references
- Provider configuration
- Module configuration (if downloaded)

It **does NOT**:

- Create infrastructure
- Contact AWS
- Check if AWS resources already exist
- Show infrastructure changes

---

# Why do we need it?

Without validation:

- Small syntax mistakes reach production.
- `terraform plan` fails unexpectedly.
- Developers waste time debugging simple errors.

With validation:

- Catch mistakes early
- Faster development
- Cleaner CI/CD pipelines
- Better code quality

---

# Internal Workflow

```text
Developer
    │
    ▼
terraform validate
    │
    ▼
Read all *.tf files
    │
    ▼
Check HCL syntax
    │
    ▼
Verify references
    │
    ▼
Validate providers/modules
    │
    ▼
Configuration Valid
```

---

# Example

## Valid Configuration

```hcl
resource "aws_s3_bucket" "demo" {
  bucket = "my-demo-bucket"
}
```

Run:

```bash
terraform validate
```

Output:

```text
Success! The configuration is valid.
```

---

## Invalid Configuration

```hcl
resource "aws_s3_bucket" "demo" {

bucket =

}
```

Run:

```bash
terraform validate
```

Output:

```text
Error: Invalid expression
```

---

# Common Validation Errors

## Missing Argument

```text
Error: Missing required argument
```

Example:

```hcl
resource "aws_s3_bucket" "demo" {
}
```

Reason:

Required arguments are missing.

---

## Reference Error

```text
Error: Reference to undeclared resource
```

Example:

```hcl
output "bucket" {
  value = aws_s3_bucket.demo123.id
}
```

Reason:

The resource does not exist.

---

## Variable Not Declared

```text
Error: Reference to undeclared input variable
```

Reason:

Variable is used but not defined.

---

## Invalid Block

```text
Error: Unsupported block type
```

Reason:

Terraform does not recognize the block.

---

# Common Use Cases

### Before Planning

```bash
terraform validate
terraform plan
```

---

### Before Git Commit

```bash
terraform fmt
terraform validate
git commit
```

---

### CI/CD Pipeline

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
```

---

# Best Practices

✅ Run after every code change.

✅ Run after `terraform fmt`.

✅ Validate before opening a Pull Request.

✅ Include validation in CI/CD.

---

# Security Best Practices

- Prevent invalid infrastructure definitions.
- Detect configuration mistakes early.
- Combine with security scanners like:
  - tfsec
  - Checkov
  - Terrascan

---

# Real Production Workflow

```text
Developer
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
Code Review
    │
    ▼
terraform apply
```

---

# Important Interview Questions

## 1. What is `terraform validate`?

**Answer:**

It checks whether Terraform configuration is syntactically valid and internally consistent.

---

## 2. Does `terraform validate` create resources?

**Answer:**

No.

It only validates configuration files.

---

## 3. Does `terraform validate` contact AWS?

**Answer:**

No.

It validates the local configuration only.

---

## 4. Difference between `terraform fmt` and `terraform validate`?

| terraform fmt | terraform validate |
|---------------|--------------------|
| Formats code | Validates code |
| Improves readability | Detects configuration errors |
| Changes file formatting | Does not modify files |

---

## 5. Can `terraform validate` detect syntax errors?

**Answer:**

Yes.

It detects HCL syntax and configuration errors.

---

## 6. Can `terraform validate` detect AWS permission issues?

**Answer:**

No.

Permissions are checked when running `terraform plan` or `terraform apply`.

---

## 7. Why is it used in CI/CD?

**Answer:**

To prevent invalid Terraform configurations from reaching production.

---

## 8. Which command usually comes after `terraform validate`?

**Answer:**

```bash
terraform plan
```

---

# Quick Revision

- Checks Terraform configuration
- Finds syntax errors
- Finds reference errors
- Does not modify infrastructure
- Does not contact AWS
- Used before `terraform plan`

---

# Cheat Sheet

| Command | Purpose |
|----------|---------|
| `terraform validate` | Validate Terraform configuration |
| `terraform fmt` | Format Terraform files |
| `terraform plan` | Generate execution plan |

---

# Mini Practice

1. Create a valid Terraform configuration.
2. Run:

```bash
terraform validate
```

3. Introduce a syntax error.
4. Run validation again.
5. Fix the error and validate successfully.

---

# Summary

`terraform validate` ensures that your Terraform configuration is syntactically correct and internally consistent before execution. It catches errors early in the development process, making it an essential quality check before running `terraform plan` or `terraform apply`. In professional DevOps environments, `terraform validate` is commonly integrated into CI/CD pipelines to prevent invalid configurations from being deployed.
