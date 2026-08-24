# 🚀 Project 07 — Local File with Terraform Lists

## 📖 Overview

In this project, I introduced Terraform's `list` data type and used a list variable to manage multiple team members.

The project builds on the variable concepts learned in Project 06 and demonstrates how Terraform can work with collections of values.

---

## 🎯 Objective

The objectives of this project are to:

* Understand Terraform lists.
* Learn the `list(string)` type.
* Define list variables.
* Provide list values through `terraform.tfvars`.
* Access list elements using indexes.
* Use the `length()` function.
* Understand duplicate values in lists.
* Understand the limitations of manually indexing lists.

---

## 📁 Project Structure

```text
07-local-file-with-lists/
│
├── README.md
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── .gitignore
└── .terraform.lock.hcl
```

Terraform working directories and state files are excluded from Git.

---
## 🔧 Terraform Commands Used
Initialize
terraform init
Format
terraform fmt
Validate
terraform validate
Plan
terraform plan
Apply
terraform apply
View outputs
terraform output
List resources
terraform state list
Inspect state
terraform show
Destroy
terraform destroy
🔍 Verification

After running:

terraform apply

Terraform creates:

terraform-project-info.txt

Example output:

Terraform Project Information
=============================

Project Name: Terraform Portfolio
Environment: development
Owner: DevOps Student

Team Members
------------

First Team Member: Kangana
Second Team Member: Ruchi
Third Team Member: Sonal
Fourth Team Member: chinki

Total Team Members: 4
🧪 Adding a Team Member

The list can be extended:

team_members = [
  "Kangana",
  "Ruchi",
  "Sonal",
  "chinki",
  "Sudha"
]

Running:

terraform plan

will detect the change.

After:

terraform apply

the team member count becomes:

5
🧪 List Ordering

Lists are ordered collections.

For example:

team_members = [
  "Kangana",
  "Ruchi",
  "Sonal",
  "chinki"
]

is different from:

team_members = [
   "chinki",
  "Ruchi",
  "Sonal",
  "Kangana"
]

because the indexes point to different values.

🧪 Duplicate Values

Terraform lists can contain duplicates:

team_members = [
  "Kangana",
  "Ruchi",
  "Sonal",
  "Kangana"
]

The list contains four elements.

This behavior differs from Terraform sets, which are designed for unique values.

⚠️ List Index Limitations

Manually accessing indexes:

var.team_members[0]
var.team_members[1]
var.team_members[2]
var.team_members[3]

does not scale well.

If there are 100 team members, manually accessing each index would make the configuration difficult to maintain.

Terraform provides more scalable approaches such as:

for expressions
count
for_each

These will be explored in upcoming projects.

🧪 Idempotency Test

Run:

terraform plan

without making changes.

Terraform should report that there are no changes when the actual resource matches the configuration.

## 🧹 Cleanup

Destroy the generated resource:

```bash
terraform destroy
```

Confirm:

```text
yes
```

Terraform should remove:

```text
terraform-project-info.txt
```

---

## ❗ Common Errors

### Invalid index

If the list contains four elements:

```text
0
1
2
3
```

then accessing:

```hcl
var.team_members[4]
```

will produce an invalid index error.

### Incorrect type

If the variable expects:

```hcl
type = list(string)
```

all elements must be strings.

### Missing variable

If `team_members` isn't declared, Terraform will report an undeclared variable error.

### Unexpected list changes

Remember that lists are ordered. Changing the order changes which value belongs to each index.

---

## 💡 Best Practices

* Use explicit collection types such as `list(string)`.
* Give list variables meaningful names.
* Add descriptions to variables.
* Avoid hardcoded indexes when working with dynamic collections.
* Use `length()` when you need the number of elements.
* Use `for` expressions for scalable list processing.
* Use `count` or `for_each` when creating multiple resources.
* Never store secrets in Git.
* Review `terraform plan` before applying changes.
* Run `terraform fmt` and `terraform validate`.

---

## 🎤 Interview Questions

### 1. What is a Terraform list?

A list is an ordered collection of values.

### 2. How do you define a list of strings?

```hcl
type = list(string)
```

### 3. What is the first index of a Terraform list?

`0`.

### 4. How do you access an element?

```hcl
var.team_members[0]
```

### 5. What does `length()` return?

The number of elements in the collection.

### 6. Can lists contain duplicate values?

Yes.

### 7. Does order matter in a list?

Yes.

### 8. What happens if you access an invalid index?

Terraform reports an invalid index error.

### 9. Why shouldn't you manually access hundreds of list indexes?

It doesn't scale. Terraform provides `for` expressions, `count`, and `for_each` for handling collections dynamically.

---

## 📚 Official Documentation

* [Terraform Type Constraints](https://developer.hashicorp.com/terraform/language/expressions/type-constraints)
* [Terraform Collection Types](https://developer.hashicorp.com/terraform/language/expressions/type-constraints#collection-types)
* [Terraform Functions](https://developer.hashicorp.com/terraform/language/functions)
* [Terraform `length` Function](https://developer.hashicorp.com/terraform/language/functions/length)

---

