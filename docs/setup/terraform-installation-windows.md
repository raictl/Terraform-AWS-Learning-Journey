# Install Terraform on Windows

> A complete step-by-step guide to installing and configuring Terraform on Windows.

---

# 📖 Overview

Terraform is an **Infrastructure as Code (IaC)** tool developed by **HashiCorp**. It allows you to define, provision, and manage infrastructure using configuration files instead of manually creating resources through cloud provider consoles.

This guide walks you through installing Terraform on Windows and verifying that it is correctly configured.

---

# 🎯 Objective

By the end of this guide, you will be able to:

- Understand what Terraform is.
- Install Terraform on Windows.
- Configure Terraform so it can be used from any Command Prompt or PowerShell window.
- Verify that Terraform is installed correctly.
- Run your first Terraform command.

---

# 📋 Prerequisites

Before you begin, ensure you have:

- A Windows 10 or Windows 11 computer.
- Administrator access (recommended).
- A stable internet connection.
- Basic knowledge of Command Prompt or PowerShell.

---

# 📝 Step 1 – Download Terraform

1. Open your web browser.

2. Visit the official Terraform download page:

   https://developer.hashicorp.com/terraform/downloads

3. Select:

   - **Operating System:** Windows
   - **Architecture:** amd64 (64-bit)

4. Download the ZIP file.

Example:

```
terraform_1.x.x_windows_amd64.zip
```

> **Note**
>
> Always download Terraform from the official HashiCorp website.

---

# 📝 Step 2 – Create a Terraform Directory

Create a folder where Terraform will be stored.

Example:

```
C:\Terraform
```

or

```
C:\Tools\Terraform
```

This folder will permanently store the Terraform executable.

---

# 📝 Step 3 – Extract the ZIP File

1. Locate the downloaded ZIP file.

2. Right-click it.

3. Select **Extract All...**

4. Extract the contents into:

```
C:\Terraform
```

After extraction, your folder should look like:

```
C:\Terraform
│
└── terraform.exe
```

---

# 📝 Step 4 – Add Terraform to the System PATH

Adding Terraform to the **PATH** allows you to run the `terraform` command from any directory.

## Method

### 1. Open Windows Search

Search for:

```
Environment Variables
```

Click:

```
Edit the system environment variables
```

---

### 2. Click

```
Environment Variables
```

---

### 3. Under

```
System Variables
```

Find

```
Path
```

Click

```
Edit
```

---

### 4. Click

```
New
```

Add

```
C:\Terraform
```

---

### 5. Click

```
OK
```

until all windows are closed.

---

# 📝 Step 5 – Restart Terminal

Close all Command Prompt and PowerShell windows.

Open a new terminal.

This is necessary because PATH changes are not applied to already-open terminals.

---

# 📝 Step 6 – Verify Installation

Open Command Prompt.

Run:

```bash
terraform version
```

Expected output:

```text
Terraform v1.x.x
on windows_amd64
```

Congratulations!

Terraform is now installed successfully.

---

# 📝 Step 7 – View Terraform Help

Run:

```bash
terraform
```

Terraform will display available commands such as:

```
init
plan
apply
destroy
fmt
validate
version
```

This confirms Terraform is working properly.

---

# 📝 Step 8 – Check Terraform Version

To display the installed version:

```bash
terraform version
```

Example:

```text
Terraform v1.13.0
```

(Your version may be different.)

---

# 📝 Step 9 – Verify PATH Configuration

Run:

```bash
where terraform
```

Expected output:

```text
C:\Terraform\terraform.exe
```

If you see this path, the PATH variable is configured correctly.

---

# 📝 Step 10 – Create Your First Terraform Project

Create a new folder.

Example:

```
terraform-demo
```

Open Command Prompt.

Navigate to the folder.

```bash
cd terraform-demo
```

Create a file named:

```
main.tf
```

Add the following content:

```hcl
terraform {
  required_version = ">= 1.0.0"
}
```

Save the file.

Run:

```bash
terraform init
```

Expected output:

```text
Terraform has been successfully initialized!
```

Congratulations!

You have successfully initialized your first Terraform project.

---

# ✅ Verification Checklist

Verify the following:

- [ ] Terraform downloaded successfully.
- [ ] ZIP extracted.
- [ ] PATH variable configured.
- [ ] Terminal restarted.
- [ ] `terraform version` works.
- [ ] `where terraform` shows the executable.
- [ ] `terraform init` completes successfully.

---

# ❗ Common Errors and Solutions

## Error

```
'terraform' is not recognized as an internal or external command
```

### Cause

Terraform is not in the PATH.

### Solution

- Verify `terraform.exe` exists.
- Recheck the PATH variable.
- Restart Command Prompt.

---

## Error

```
Access is denied
```

### Cause

Insufficient permissions.

### Solution

- Run Command Prompt as Administrator.
- Ensure the Terraform directory is accessible.

---

## Error

```
No such file or directory
```

### Cause

You are not in the correct directory.

### Solution

Run:

```bash
cd path\to\your\project
```

---

## Error

Wrong Terraform version

### Cause

Multiple Terraform installations exist.

### Solution

Run:

```bash
where terraform
```

Remove older installations or adjust your PATH so the desired version appears first.

---

# 💡 Best Practices

- Always download Terraform from the official HashiCorp website.
- Keep Terraform updated to the latest stable release.
- Use version control (Git) for your Terraform code.
- Do **not** store AWS credentials directly in Terraform files.
- Never commit sensitive files like `terraform.tfvars` containing secrets to GitHub.
- Use `terraform fmt` to format your code before committing.
- Run `terraform validate` before applying infrastructure changes.
- Read the execution plan (`terraform plan`) before running `terraform apply`.

---

# 📚 Useful Terraform Commands

| Command | Description |
|----------|-------------|
| `terraform version` | Display installed version |
| `terraform init` | Initialize a Terraform project |
| `terraform validate` | Validate configuration files |
| `terraform fmt` | Format Terraform code |
| `terraform plan` | Preview infrastructure changes |
| `terraform apply` | Apply infrastructure changes |
| `terraform destroy` | Destroy managed infrastructure |
| `terraform providers` | List providers used by the project |

---

# 📚 Official Documentation

- Terraform Documentation: https://developer.hashicorp.com/terraform/docs
- Terraform Downloads: https://developer.hashicorp.com/terraform/downloads
- Terraform CLI Commands: https://developer.hashicorp.com/terraform/cli

---

# 🎉 What's Next?

Now that Terraform is installed, continue with the next setup guide:

- Install AWS CLI
- Create an AWS Account
- Create an IAM User
- Configure AWS CLI
- Build your first Terraform project

Happy Learning! 🚀
