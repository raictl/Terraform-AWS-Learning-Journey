# 🚀 Project 12 — Terraform Provisioners

> Learn how Terraform Provisioners execute commands during resource creation or destruction, and understand why they should be used carefully.

---

## 📖 Overview

Terraform is primarily designed to **manage infrastructure declaratively**.

However, sometimes we need to execute a command after Terraform creates or updates a resource.

For this purpose, Terraform provides **Provisioners**.

In this project, we will learn how to use the `local-exec` provisioner to execute a local command when Terraform creates a resource.

We will use the **Local provider**, so this project does not require AWS infrastructure.

---

## 🎯 Objective

By completing this project, you will learn:

* What Terraform Provisioners are
* Why Provisioners exist
* How `local-exec` works
* When a Provisioner executes
* How Provisioners are attached to resources
* How to use commands with `local-exec`
* Creation-time Provisioners
* Destruction-time Provisioners
* Why Provisioners should generally be a last resort
* Common Provisioner errors
* Provisioner best practices

---

# 🔧 Step 1 — Create the Project Directory

Create the project directory:

```bash
mkdir 12-terraform-provisioners
```

Move into it:

```bash
cd 12-terraform-provisioners
```

---

# 📝 Step 2 — Create `main.tf`

Create:

```text
main.tf
```

Add:

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

resource "local_file" "application" {
  filename = "${path.module}/application.txt"

  content = <<-EOT
    Application: Terraform Provisioner Demo
    Environment: ${var.environment}
    Managed By: Terraform
  EOT

  provisioner "local-exec" {
    command = "echo Terraform provisioner executed successfully > ${path.module}/provisioner.log"
  }
}
```

---

# 🧠 Understanding the Configuration

## Terraform Block

```hcl
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
```

This tells Terraform that the project requires the Local provider.

---

## Provider

```hcl
provider "local" {}
```

The Local provider allows Terraform to manage resources on the local machine.

---

## Resource

```hcl
resource "local_file" "application" {
```

This creates a local file.

---

## Filename

```hcl
filename = "${path.module}/application.txt"
```

Terraform creates:

```text
application.txt
```

inside the project directory.

---

## Content

```hcl
content = <<-EOT
  Application: Terraform Provisioner Demo
  Environment: ${var.environment}
  Managed By: Terraform
EOT
```

This creates content inside the file.

---

# ⚙️ Step 3 — Add the Provisioner

The important part of this project is:

```hcl
provisioner "local-exec" {
  command = "echo Terraform provisioner executed successfully > ${path.module}/provisioner.log"
}
```

The `local-exec` provisioner executes a command on the **machine where Terraform is running**.

In this example:

```text
Terraform
    ↓
Creates application.txt
    ↓
Runs local-exec
    ↓
Creates provisioner.log
```

---

# 📝 Step 4 — Create `variables.tf`

Create:

```text
variables.tf
```

Add:

```hcl
variable "environment" {
  description = "Deployment environment"
  type        = string

  default = "development"

  validation {
    condition = contains(
      ["development", "staging", "production"],
      var.environment
    )

    error_message = "Environment must be development, staging, or production."
  }
}
```

---

# 📝 Step 5 — Create `outputs.tf`

Create:

```text
outputs.tf
```

Add:

```hcl
output "application_file" {
  description = "Path of the application file"
  value       = local_file.application.filename
}

output "provisioner_log" {
  description = "Path of the provisioner log"
  value       = "${path.module}/provisioner.log"
}
```

---

# 🔄 Step 6 — Initialize Terraform

Run:

```bash
terraform init
```

Terraform will download the Local provider.

You should see a successful initialization message.

---

# 🧹 Step 7 — Format the Configuration

Run:

```bash
terraform fmt
```

Terraform will format your `.tf` files.

---

# 🔍 Step 8 — Validate the Configuration

Run:

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

# 📋 Step 9 — Review the Execution Plan

Run:

```bash
terraform plan
```

Terraform should show that it will create the `local_file.application` resource.

---

# 🚀 Step 10 — Apply the Configuration

Run:

```bash
terraform apply
```

Type:

```text
yes
```

Terraform will:

1. Create `application.txt`
2. Execute the `local-exec` provisioner
3. Create `provisioner.log`

---

# 🔎 Step 11 — Verify the Files

Your directory should now contain:

```text
12-terraform-provisioners/
│
├── application.txt
├── provisioner.log
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

Check `application.txt`.

Expected content:

```text
Application: Terraform Provisioner Demo
Environment: development
Managed By: Terraform
```

Check `provisioner.log`.

Expected content:

```text
Terraform provisioner executed successfully
```

---

# 📤 Step 12 — Check Terraform Outputs

Run:

```bash
terraform output
```

You should see something similar to:

```text
application_file = "./application.txt"
provisioner_log = "./provisioner.log"
```

---

# 🧪 Step 13 — Experiment with Variables

You can change the environment using:

```bash
terraform apply -var="environment=production"
```

Terraform will update the file.

The generated file should contain:

```text
Environment: production
```

---

# 🧠 What is a Provisioner?

A Terraform Provisioner allows Terraform to execute an action after a resource is created or during resource destruction.

Conceptually:

```text
Resource
   ↓
Terraform creates resource
   ↓
Provisioner executes command
```

Provisioners are useful when Terraform itself does not provide a suitable way to perform a required action.

---

# 🏃 `local-exec`

`local-exec` executes a command on the machine running Terraform.

Example:

```hcl
provisioner "local-exec" {
  command = "echo Hello Terraform"
}
```

If Terraform is running on your laptop, the command runs on your laptop.

If Terraform is running in a CI/CD pipeline, the command runs in the CI/CD environment.

---

# 🌐 `remote-exec`

`remote-exec` executes commands on a remote machine.

Conceptually:

```text
Terraform
    │
    │ SSH / WinRM
    ▼
Remote Server
    │
    ▼
Command executes
```

Example:

```hcl
provisioner "remote-exec" {
  inline = [
    "sudo apt update",
    "sudo apt install nginx -y"
  ]
}
```

Remote execution requires appropriate connection configuration.

---

# ⏱️ Creation-Time Provisioner

By default, a Provisioner runs during resource creation.

Example:

```hcl
resource "local_file" "example" {
  filename = "example.txt"
  content  = "Hello Terraform"

  provisioner "local-exec" {
    command = "echo Resource created"
  }
}
```

Terraform creates the resource and then executes the Provisioner.

---

# 🗑️ Destruction-Time Provisioner

A Provisioner can also execute when a resource is destroyed.

Example:

```hcl
provisioner "local-exec" {
  when    = destroy
  command = "echo Resource destroyed"
}
```

This is called a **destruction-time Provisioner**.

---

# ⚠️ Important: Provisioners Are a Last Resort

Terraform documentation generally recommends using Provisioners only when necessary.

Why?

Terraform works best when infrastructure is represented directly as resources.

For example:

```text
Terraform Resource
        ↓
Infrastructure
```

Provisioners introduce an imperative command-execution step:

```text
Terraform
    ↓
Resource
    ↓
Shell Command
    ↓
External Action
```

This can make infrastructure:

* harder to reproduce
* harder to debug
* dependent on the local environment
* less predictable
* harder to maintain

---

# 💡 Better Alternatives

Before using a Provisioner, ask:

> "Can Terraform manage this directly?"

For example:

Instead of:

```hcl
provisioner "local-exec" {
  command = "some-command"
}
```

prefer a Terraform resource or provider feature when one exists.

The preferred approach is generally:

```text
Terraform Resource
       ↓
Provider API
       ↓
Infrastructure
```

rather than:

```text
Terraform
   ↓
Shell command
   ↓
Infrastructure
```

---

# ❗ Common Errors & Solutions

## Error 1 — `cmd` executable not found on Windows

You may see:

```text
exec: "cmd": executable file not found in %PATH%
```

This means Terraform cannot locate the Windows command interpreter.

Check:

```cmd
where cmd
```

You can also check:

```cmd
echo %ComSpec%
```

Normally, Windows should have:

```text
C:\Windows\System32\cmd.exe
```

If necessary, verify that:

```text
C:\Windows\System32
```

exists in your PATH.

---

## Error 2 — Provisioner doesn't execute again

Provisioners are associated with resource lifecycle events.

If the resource hasn't been recreated, the creation-time Provisioner may not execute again.

You can test this by destroying and recreating the resource:

```bash
terraform destroy
```

Then:

```bash
terraform apply
```

---

## Error 3 — Command works manually but fails in Terraform

Remember that the command executes in the environment where Terraform runs.

Check:

* PATH
* environment variables
* permissions
* shell availability
* working directory
* operating system differences

---

# 🔐 Best Practices

### 1. Avoid Provisioners when possible

Prefer native Terraform resources.

---

### 2. Keep commands simple

Avoid large shell scripts inside Terraform.

---

### 3. Don't hardcode secrets

Never place passwords, API keys, or tokens directly inside:

```hcl
command = "..."
```

---

### 4. Understand where the command executes

For `local-exec`:

```text
Terraform machine
```

For `remote-exec`:

```text
Remote machine
```

---

### 5. Test Provisioners carefully

Provisioners can have side effects outside Terraform's normal resource management.

---

### 6. Prefer declarative infrastructure

Whenever possible:

```text
Terraform Resource
        ↓
Provider
        ↓
Infrastructure
```

is preferable to:

```text
Terraform
        ↓
Provisioner
        ↓
Shell command
```

---

# 🧹 Step 14 — Destroy the Infrastructure

Run:

```bash
terraform destroy
```

Confirm with:

```text
yes
```

Terraform will remove the managed local file.

You can then verify the project directory.

---

# 🧠 Important Learning

Terraform Provisioners are **not the primary way to manage infrastructure**.

Think of them as a tool you use when:

> Terraform does not provide a suitable native solution for the required action.

This distinction is important for real-world DevOps work and Terraform interviews.

---

# 🎯 Real-World Use Cases

Provisioners can sometimes be useful for:

* Running a one-time local command
* Triggering an external script
* Performing an action unavailable through a provider
* Bootstrapping specific systems in exceptional cases
* Integrating with legacy environments

However, always investigate a native Terraform/provider solution first.

---

# 💼 Interview Questions

### 1. What is a Terraform Provisioner?

A Provisioner allows Terraform to execute commands or scripts during resource lifecycle events.

---

### 2. What is `local-exec`?

`local-exec` executes a command on the machine where Terraform is running.

---

### 3. What is `remote-exec`?

`remote-exec` executes commands on a remote machine using an appropriate connection mechanism.

---

### 4. Are Provisioners recommended?

Generally, Provisioners should be treated as a **last resort** when no suitable native Terraform solution exists.

---

### 5. What is the difference between `local-exec` and `remote-exec`?

| Provisioner   | Execution Location        |
| ------------- | ------------------------- |
| `local-exec`  | Machine running Terraform |
| `remote-exec` | Remote machine            |

---

### 6. When does a Provisioner normally execute?

A creation-time Provisioner executes after the associated resource is created.

---

### 7. Can a Provisioner execute during destruction?

Yes.

Example:

```hcl
provisioner "local-exec" {
  when    = destroy
  command = "echo Destroyed"
}
```

---

### 8. Why shouldn't Provisioners be overused?

Because they introduce imperative commands and can make Terraform configurations less predictable, portable, and maintainable.

---

# 📚 Terraform Commands Used

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy
```

---

# 📚 Official Documentation

* Terraform Provisioners
* `local-exec` Provisioner
* `remote-exec` Provisioner
* Terraform Resource Provisioners
* Local Provider Documentation

---


