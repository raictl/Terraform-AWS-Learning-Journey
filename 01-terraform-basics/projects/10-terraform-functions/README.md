# 🚀 Project 10 — Terraform Functions

## 📖 Overview


In this project, I learned how to use Terraform built-in functions to transform strings, process collections, generate formatted values, and create standardized project names.

The project demonstrates practical usage of Terraform functions including `length()`, `upper()`, `lower()`, `trimspace()`, `replace()`, `join()`, `split()`, `format()`, and `contains()`.

---

## 🎯 Objective

The objectives of this project are to:

* Understand Terraform built-in functions.
* Learn how Terraform functions process data.
* Transform and normalize strings.
* Convert lists to strings.
* Convert strings to lists.
* Generate formatted strings.
* Check collection membership.
* Combine multiple functions.
* Create standardized resource naming.
* Practice Terraform expressions using `terraform console`.

---

## 🧠 Concepts Learned

* Terraform functions
* String functions
* Collection functions
* `length()`
* `upper()`
* `lower()`
* `trimspace()`
* `replace()`
* `join()`
* `split()`
* `format()`
* `contains()`
* Function composition
* Local values
* Data transformation
* Standardized naming

---

## 🔧 Terraform Functions

Terraform provides built-in functions that can transform and process values.

Basic example:

```hcl
upper("terraform")
```

Result:

```text
TERRAFORM
```

---

## 🔤 String Functions

### `upper()`

Converts a string to uppercase.

```hcl
upper("terraform")
```

Result:

```text
TERRAFORM
```

---

### `lower()`

Converts a string to lowercase.

```hcl
lower("TERRAFORM")
```

Result:

```text
terraform
```

---

### `trimspace()`

Removes leading and trailing whitespace.

```hcl
trimspace("   Terraform   ")
```

Result:

```text
Terraform
```

---

### `replace()`

Replaces matching text.

```hcl
replace("terraform portfolio", " ", "-")
```

Result:

```text
terraform-portfolio
```

---

## 📏 `length()`

The `length()` function returns the length of a string or collection.

Example:

```hcl
length("Terraform")
```

Result:

```text
9
```

For a list:

```hcl
length(["development", "staging", "production"])
```

Result:

```text
3
```

---

## 🔗 `join()`

`join()` converts collection elements into a string.

Example:

```hcl
join(", ", ["development", "staging", "production"])
```

Result:

```text
development, staging, production
```

---

## ✂️ `split()`

`split()` converts a string into a list.

Example:

```hcl
split(",", "development,staging,production")
```

Result:

```text
[
  "development",
  "staging",
  "production"
]
```

---

## 🔄 `join()` vs `split()`

```text
join()
LIST ───────────────► STRING


split()
STRING ─────────────► LIST
```

Example:

```hcl
join("-", ["terraform", "aws", "devops"])
```

produces:

```text
terraform-aws-devops
```

While:

```hcl
split("-", "terraform-aws-devops")
```

produces:

```text
["terraform", "aws", "devops"]
```

---

## 📝 `format()`

The `format()` function creates formatted strings.

Example:

```hcl
format(
  "%s - %s Environment",
  "Terraform Portfolio",
  "PRODUCTION"
)
```

Result:

```text
Terraform Portfolio - PRODUCTION Environment
```

---

## 🔎 `contains()`

The `contains()` function checks whether a collection contains a particular value.

Example:

```hcl
contains(
  ["development", "staging", "production"],
  "production"
)
```

Result:

```text
true
```

---

## 🔗 Function Composition

Multiple functions can be combined.

Example:

```hcl
replace(
  lower(
    trimspace(var.project_name)
  ),
  " ",
  "-"
)
```

The transformation is:

```text
"   Terraform Portfolio   "
             │
             ▼
        trimspace()
             │
             ▼
"Terraform Portfolio"
             │
             ▼
           lower()
             │
             ▼
"terraform portfolio"
             │
             ▼
         replace()
             │
             ▼
"terraform-portfolio"
```

---

## 🏷️ Standardized Resource Naming

The project demonstrates how functions can be combined to generate standardized names.

Example input:

```text
Project Name:  My Terraform App
Environment:   PRODUCTION
```

Expected standardized name:

```text
my-terraform-app-production
```

Example Terraform:

```hcl
standardized_name = format(
  "%s-%s",
  replace(
    lower(
      trimspace(var.project_name)
    ),
    " ",
    "-"
  ),
  lower(var.environment)
)
```

---

## 🧪 Example Output

For:

```hcl
project_name = "   Terraform Portfolio   "

environment = "production"
```

Terraform generates values similar to:

```text
Project Name:
Terraform Portfolio

Project Slug:
terraform-portfolio

Environment:
production

Environment (Uppercase):
PRODUCTION

Environment Length:
10

Available Environments:
development, staging, production

Formatted Title:
Terraform Portfolio - PRODUCTION Environment

Production Environment Available:
true
```

---

## 🖥️ Terraform Console

Terraform provides `terraform console` for experimenting with expressions.

Start:

```bash
terraform console
```

Examples:

```hcl
upper("terraform")
```

```hcl
lower("TERRAFORM")
```

```hcl
length("Terraform")
```

```hcl
trimspace("   Terraform   ")
```

```hcl
replace("terraform portfolio", " ", "-")
```

```hcl
join("-", ["terraform", "aws", "devops"])
```

```hcl
split(",", "dev,stage,prod")
```

```hcl
contains(["dev", "stage", "prod"], "prod")
```

```hcl
format("%s-%s", "terraform", "devops")
```

Exit:

```text
exit
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

### View Outputs

```bash
terraform output
```

### Console

```bash
terraform console
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
project-info.txt
```

The file contains the calculated and transformed values generated using Terraform functions.

---

## 🌎 Real-World Use Cases

Terraform functions are commonly useful for:

* Standardizing resource names.
* Normalizing user input.
* Creating environment-specific names.
* Converting lists into strings.
* Converting strings into lists.
* Building dynamic tags.
* Formatting resource descriptions.
* Processing configuration values.
* Generating consistent identifiers.

Example:

```text
Application Name
       │
       ▼
trimspace()
       │
       ▼
lower()
       │
       ▼
replace()
       │
       ▼
Standardized Resource Name
```
---

## 💡 Best Practices

* Use functions to standardize naming.
* Normalize user input when appropriate.
* Use `trimspace()` when whitespace can cause problems.
* Use `lower()` for consistent resource naming.
* Use `join()` when converting collections to strings.
* Use `split()` when converting strings to collections.
* Use locals for reusable calculations.
* Keep complex expressions readable.
* Use `terraform console` to test expressions.
* Don't memorize every function; learn how to find the appropriate function for a problem.
* Always run `terraform fmt` and `terraform validate`.

---

## 🎤 Interview Questions

### 1. What is a Terraform function?

A built-in operation that accepts input and returns a calculated or transformed value.

### 2. What is function composition?

Combining multiple functions so that the output of one function becomes the input to another.

Example:

```hcl
replace(
  lower(
    trimspace(var.project_name)
  ),
  " ",
  "-"
)
```

---

## 📚 Official Documentation

* [Terraform Functions](https://developer.hashicorp.com/terraform/language/functions)
* [Terraform String Functions](https://developer.hashicorp.com/terraform/language/functions#string-functions)
* [Terraform Collection Functions](https://developer.hashicorp.com/terraform/language/functions#collection-function)
* [Terraform `join()` Function](https://developer.hashicorp.com/terraform/language/functions/join)
* [Terraform `split()` Function](https://developer.hashicorp.com/terraform/language/functions/split)
* [Terraform `format()` Function](https://developer.hashicorp.com/terraform/language/functions/format)
* [Terraform Console](https://developer.hashicorp.com/terraform/cli/commands/console)

---
