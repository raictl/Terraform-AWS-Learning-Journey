# 🚀 Project 08 — Local File with Terraform Maps

## 📖 Overview

In this project, I introduced Terraform's `map` data type and used key-value configuration to generate a local project information file.

The project builds on the list and variable concepts learned in previous projects and introduces an important collection type commonly used in real-world Terraform configurations.

---

## 🎯 Objective

The objectives of this project are to:

* Understand Terraform maps.
* Learn the `map(string)` type.
* Understand key-value pairs.
* Access map values using keys.
* Learn bracket notation for map access.
* Understand the `keys()` function.
* Understand the `values()` function.
* Use `length()` with maps.
* Compare lists and maps.
* Understand why maps are useful for infrastructure configuration.
* Prepare for Terraform tags and advanced configuration patterns.

---

## 🧠 Concepts Learned

* Terraform maps
* `map(string)`
* Key-value pairs
* Map indexing
* Map keys
* Map values
* `keys()`
* `values()`
* `length()`
* Input variables
* `terraform.tfvars`
* Terraform outputs
* Terraform expressions
* Collection types

---

## 📁 Project Structure

```text
08-local-file-with-maps/
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
## 🗺️ Terraform Map

The project defines:

```hcl
variable "project_settings" {
  description = "Configuration settings for the Terraform project"
  type        = map(string)

  default = {
    environment = "development"
    owner       = "DevOps Student"
    department  = "Engineering"
    application = "Terraform Learning"
  }
}
```

A Terraform map stores values using keys:

```text
environment → development
owner       → DevOps Student
department  → Engineering
application → Terraform Learning
```

---

## 🔑 Accessing Map Values

A map value can be accessed using its key:

```hcl
var.project_settings["environment"]
```

This returns:

```text
development
```

Another example:

```hcl
var.project_settings["owner"]
```

returns:

```text
DevOps Student
```

---

## 🔢 List vs Map

### List

```hcl
team_members = [
  "Alice",
  "Bob",
  "Charlie"
]
```

Access by index:

```hcl
var.team_members[0]
```

### Map

```hcl
project_settings = {
  environment = "development"
  owner       = "DevOps Student"
}
```

Access by key:

```hcl
var.project_settings["environment"]
```

### Key Difference

```text
List
│
└── Access using index


Map
│
└── Access using key
```

---

## 📏 Map Length

Terraform's `length()` function can be used with maps:

```hcl
length(var.project_settings)
```

For four settings:

```text
4
```

---

## 🔑 Getting Map Keys

Terraform provides:

```hcl
keys(var.project_settings)
```

This returns the keys stored in the map.

Example:

```text
environment
owner
department
application
```

---

## 💎 Getting Map Values

Terraform provides:

```hcl
values(var.project_settings)
```

This returns the values stored in the map.

Example:

```text
development
DevOps Student
Engineering
Terraform Learning
```

---

## 📄 Generated File

The project creates:

```text
terraform-project-info.txt
```

Example:

```text
Terraform Project Information
=============================

Project Name: Terraform Portfolio

Project Settings
----------------

Environment: development
Owner: DevOps Student
Department: Engineering
Application: Terraform Learning

Total Settings: 4
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

Run:

```bash
terraform apply
```

Then verify:

```text
terraform-project-info.txt
```

Also run:

```bash
terraform output
```

Expected output includes:

```text
environment = "development"
owner = "DevOps Student"
settings_count = 4
```

---

## 🧪 Experiments

### Add a new setting

```hcl
cost_center = "DEV-001"
```

Then run:

```bash
terraform plan
```

Terraform should detect the configuration change.

---

### Change a value

Change:

```hcl
environment = "development"
```

to:

```hcl
environment = "production"
```

Then run:

```bash
terraform plan
```

Terraform will detect that the generated file needs to change.

---

### Retrieve keys

```bash
terraform output setting_keys
```

### Retrieve values

```bash
terraform output setting_values
```

---

## 🌎 Real-World Use Case

Maps are frequently used in Terraform for metadata and configuration.

A common example is resource tags:

```hcl
tags = {
  Environment = "production"
  Project     = "web-app"
  Owner       = "DevOps"
  ManagedBy   = "Terraform"
}
```

Understanding maps in this project prepares for real-world cloud infrastructure configuration.

---

## ⚠️ Common Errors

### Missing map key

Trying:

```hcl
var.project_settings["region"]
```

when `region` doesn't exist will cause an error.

### Incorrect type

For:

```hcl
type = map(string)
```

values should be strings.

### Duplicate keys

Map keys must be unique.

### Confusing list indexes with map keys

List:

```hcl
var.team_members[0]
```

Map:

```hcl
var.project_settings["environment"]
```

---

## 💡 Best Practices

* Use meaningful map keys.
* Use explicit types such as `map(string)`.
* Add descriptions to variables.
* Use maps for key-value configuration.
* Use maps for metadata and tags.
* Avoid hardcoded configuration when variables are more appropriate.
* Never commit secrets to Git.
* Review `terraform plan` before applying.
* Run `terraform fmt` and `terraform validate`.
* Keep Terraform configurations modular as projects become larger.

---

## 🎤 Interview Questions

### 1. What is a Terraform map?

A collection of key-value pairs.

### 2. How do you define a map of strings?

```hcl
type = map(string)
```

### 3. How do you access a map value?

```hcl
var.project_settings["environment"]
```

### 4. How is a map different from a list?

A list uses indexes while a map uses keys.

### 5. What does `keys()` do?

Returns the keys of a map.

### 6. What does `values()` do?

Returns the values of a map.

### 7. Can a map contain duplicate keys?

No.

### 8. Why are maps useful in Terraform?

They are useful for representing configuration, metadata, tags, and other key-value data.

---

## 📚 Official Documentation

* [Terraform Type Constraints](https://developer.hashicorp.com/terraform/language/expressions/type-constraints)
* [Terraform Collection Types](https://developer.hashicorp.com/terraform/language/expressions/type-constraints#collection-types)
* [Terraform Functions](https://developer.hashicorp.com/terraform/language/functions)
* [Terraform `keys` Function](https://developer.hashicorp.com/terraform/language/functions/keys)
* [Terraform `values` Function](https://developer.hashicorp.com/terraform/language/functions/values)

---
