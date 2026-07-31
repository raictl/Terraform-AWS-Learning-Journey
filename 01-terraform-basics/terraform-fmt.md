# Terraform Basics: `terraform fmt`

## 📚 Introduction

`terraform fmt` is used to **automatically format Terraform configuration files** according to the standard HashiCorp style guide.

It improves readability, keeps code consistent, and makes collaboration easier.

> **Rule:** Run `terraform fmt` before committing your Terraform code to Git.

---

# Learning Objectives

After completing this lesson, you will be able to:

- Understand the purpose of `terraform fmt`
- Format Terraform configuration files
- Know when to use `terraform fmt`
- Use common command options
- Follow Terraform coding standards
- Troubleshoot common formatting issues

---

# Syntax

Format files in the current directory:

```bash
terraform fmt
```

Common options:

```bash
terraform fmt -recursive
terraform fmt -check
terraform fmt -diff
terraform fmt -write=false
```

---

# What does `terraform fmt` do?

It automatically:

- Fixes indentation
- Aligns equal (`=`) signs
- Removes unnecessary spaces
- Standardizes block formatting
- Formats all `.tf` and `.tfvars` files

**It does NOT:**

- Validate syntax
- Create resources
- Modify infrastructure
- Check AWS credentials

---

# Why do we need it?

Without formatting:

- Code becomes difficult to read.
- Every developer writes code differently.
- Code reviews become harder.
- Git shows unnecessary formatting changes.

With `terraform fmt`:

- Consistent code style
- Easier collaboration
- Cleaner pull requests
- Better readability

---

# Internal Workflow

```text
Developer
    │
    ▼
terraform fmt
    │
    ▼
Read .tf files
    │
    ▼
Apply HashiCorp formatting rules
    │
    ▼
Rewrite formatted files
    │
    ▼
Clean & Consistent Code
```

---

# Example

### Before Formatting

```hcl
resource "aws_s3_bucket" "demo"{
bucket="my-demo-bucket"

tags={
Name="Demo Bucket"
Environment="Dev"
}
}
```

Run:

```bash
terraform fmt
```

### After Formatting

```hcl
resource "aws_s3_bucket" "demo" {
  bucket = "my-demo-bucket"

  tags = {
    Name        = "Demo Bucket"
    Environment = "Dev"
  }
}
```

---

# Common Options

## Format Current Directory

```bash
terraform fmt
```

Formats all Terraform files in the current directory.

---

## Format All Subdirectories

```bash
terraform fmt -recursive
```

Useful for large Terraform projects with multiple modules.

---

## Check Formatting Only

```bash
terraform fmt -check
```

Checks if files are formatted.

Returns a non-zero exit code if formatting is required.

Commonly used in CI/CD pipelines.

---

## Show Differences

```bash
terraform fmt -diff
```

Displays formatting changes before writing them.

Useful during code reviews.

---

## Preview Without Writing

```bash
terraform fmt -write=false
```

Shows which files need formatting without modifying them.

---

# Example Project Structure

```text
terraform-project/
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules/
    └── network/
        └── main.tf
```

Format everything:

```bash
terraform fmt -recursive
```

---

# Common Use Cases

### Before Git Commit

```bash
terraform fmt
git add .
git commit
```

---

### Before Pull Request

```bash
terraform fmt
terraform validate
```

---

### CI/CD Pipeline

```bash
terraform fmt -check
terraform validate
terraform plan
```

---

### Format Entire Repository

```bash
terraform fmt -recursive
```

---

# Common Errors

## Error

```text
No output
```

**Explanation:**

This is **not an error**.

It means all files are already properly formatted.

---

## Error

```text
Error: Invalid expression
```

**Reason:**

Your Terraform configuration contains invalid syntax.

`terraform fmt` can only format valid HCL structures.

Use:

```bash
terraform validate
```

to identify syntax problems.

---

## Files Not Formatted

Possible reasons:

- Wrong directory
- No `.tf` files
- Permission issues

Solution:

```bash
pwd
ls
terraform fmt -recursive
```

---

# Best Practices

✅ Run `terraform fmt` before every commit.

✅ Use `terraform fmt -recursive` for multi-module projects.

✅ Add formatting checks to CI/CD.

✅ Keep all Terraform files consistently formatted.

---

# Security Best Practices

`terraform fmt` does not affect security directly.

However:

- Clean code reduces configuration mistakes.
- Easier reviews help detect security issues.
- Standard formatting improves maintainability.

---

# Real Production Workflow

```text
Write Terraform Code
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

## 1. What is `terraform fmt`?

**Answer:**

It automatically formats Terraform configuration files according to HashiCorp's standard style.

---

## 2. Does `terraform fmt` validate Terraform code?

**Answer:**

No.

It only formats code.

Syntax validation is performed using:

```bash
terraform validate
```

---

## 3. Does `terraform fmt` modify infrastructure?

**Answer:**

No.

It only changes the formatting of local Terraform files.

---

## 4. What is the purpose of `terraform fmt -check`?

**Answer:**

It checks whether files are properly formatted without modifying them.

Useful for CI/CD pipelines.

---

## 5. Why is `terraform fmt -recursive` useful?

**Answer:**

It formats Terraform files in all subdirectories, making it ideal for repositories with modules.

---

## 6. Can `terraform fmt` fix syntax errors?

**Answer:**

No.

It formats code but does not correct invalid Terraform syntax.

---

## 7. Should `terraform fmt` be part of CI/CD?

**Answer:**

Yes.

Many organizations fail builds if Terraform code is not properly formatted.

---

## 8. What happens if you run `terraform fmt` on already formatted files?

**Answer:**

Nothing changes, and the command usually produces no output.

---

# Quick Revision

- Formats Terraform code
- Uses HashiCorp formatting standards
- Improves readability
- Does not validate code
- Does not create resources
- Frequently used before commits and pull requests

---

# Cheat Sheet

| Command | Purpose |
|----------|---------|
| `terraform fmt` | Format current directory |
| `terraform fmt -recursive` | Format all subdirectories |
| `terraform fmt -check` | Check formatting only |
| `terraform fmt -diff` | Show formatting differences |
| `terraform fmt -write=false` | Preview without modifying files |

---

# Mini Practice

1. Create an intentionally unformatted `main.tf`.
2. Run:

```bash
terraform fmt
```

3. Compare the file before and after formatting.

4. Format the entire repository:

```bash
terraform fmt -recursive
```

5. Verify formatting in CI mode:

```bash
terraform fmt -check
```

---

# Summary

`terraform fmt` is a code-formatting command that automatically applies HashiCorp's standard style to Terraform configuration files. While it does not validate syntax or create infrastructure, it is an essential part of professional Terraform workflows because it improves readability, reduces unnecessary Git changes, and ensures a consistent coding style across teams. Running `terraform fmt` before every commit is considered a best practice in both small projects and large production environments.
