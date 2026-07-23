# Visual Studio Code Extensions for Terraform and AWS

## 📖 Overview

Visual Studio Code (VS Code) is one of the most popular code editors for Infrastructure as Code (IaC) development. With the right extensions installed, you can improve productivity through features like syntax highlighting, auto-completion, formatting, linting, Git integration, and AWS resource management.

This guide covers the recommended VS Code extensions for Terraform and AWS development and explains how to install and configure them.

---

# 🎯 Objective

By the end of this guide, you will:

- Install essential VS Code extensions for Terraform and AWS
- Enable syntax highlighting and IntelliSense
- Format Terraform code automatically
- Improve productivity with Git integration
- Prepare VS Code for Infrastructure as Code (IaC) development

---

# 🧠 What You'll Learn

After completing this guide, you'll be able to:

- Install extensions from the VS Code Marketplace
- Configure Terraform language support
- Format Terraform code automatically
- Validate Terraform files efficiently
- Improve development workflow using Git
- Work with AWS resources from within VS Code

---

# 📋 Prerequisites

Before starting, ensure you have:

- Visual Studio Code installed
- Terraform installed
- AWS CLI installed and configured
- An active AWS account
- Internet connection

> **Note:** If you haven't installed VS Code yet, download it from:
>
> https://code.visualstudio.com/

---

# Why Use VS Code for Terraform?

VS Code provides several advantages for Infrastructure as Code development:

- Lightweight and fast
- Free and cross-platform
- Built-in Git integration
- Large extension ecosystem
- Excellent Terraform support
- Integrated terminal
- Debugging capabilities
- Customizable interface

---

# 📝 Step-by-Step Instructions

## Step 1: Open Visual Studio Code

Launch Visual Studio Code.

---

## Step 2: Open the Extensions Marketplace

You can access Extensions in one of two ways:

### Method 1

Click the **Extensions** icon in the Activity Bar on the left.

### Method 2

Use the keyboard shortcut:

**Windows/Linux**

```text
Ctrl + Shift + X
```

**macOS**

```text
Cmd + Shift + X
```

---

# Essential Extensions

The following extensions are highly recommended for Terraform and AWS development.

---

## 1. HashiCorp Terraform

### Publisher

HashiCorp

### Search

```text
Terraform
```

### Features

- Terraform syntax highlighting
- IntelliSense
- Auto-completion
- Formatting support
- Validation
- Hover documentation
- Terraform language server

### Installation

1. Search for **Terraform**.
2. Select the extension published by **HashiCorp**.
3. Click **Install**.

---

## 2. AWS Toolkit

### Publisher

Amazon Web Services

### Search

```text
AWS Toolkit
```

### Features

- AWS Explorer
- Lambda support
- CloudFormation support
- Amazon S3 integration
- Amazon ECS integration
- AWS authentication
- Resource browsing

### Installation

1. Search for **AWS Toolkit**.
2. Click **Install**.

---

## 3. GitLens

### Publisher

GitKraken

### Search

```text
GitLens
```

### Features

- Git blame annotations
- Commit history
- Repository insights
- Branch visualization
- File history

Useful for tracking Infrastructure as Code changes.

---

## 4. Error Lens

### Features

Displays compiler and validation errors directly within the editor.

Benefits include:

- Faster debugging
- Better readability
- Immediate feedback

---

## 5. YAML

### Publisher

Red Hat

Useful when working with:

- Kubernetes
- GitHub Actions
- AWS CloudFormation
- CI/CD pipelines

Features:

- YAML validation
- Auto-completion
- Formatting
- Schema support

---

## 6. Docker (Optional)

Recommended if you plan to:

- Use Docker containers
- Build local development environments
- Run Terraform inside containers

---

## 7. Markdown All in One (Optional)

Useful for:

- Documentation
- README files
- Project guides

Features include:

- Markdown shortcuts
- Table formatting
- Live preview
- Table of Contents generation

---

# Recommended Extension Summary

| Extension | Recommended | Purpose |
|-----------|-------------|---------|
| HashiCorp Terraform | ✅ | Terraform language support |
| AWS Toolkit | ✅ | AWS integration |
| GitLens | ✅ | Git productivity |
| Error Lens | ✅ | Inline error display |
| YAML | ✅ | YAML editing and validation |
| Docker | Optional | Container development |
| Markdown All in One | Optional | Documentation writing |

---

# Configure Terraform Formatting

The Terraform extension integrates with the `terraform fmt` command.

To format the current file manually:

Open the Command Palette:

```text
Ctrl + Shift + P
```

Search for:

```text
Format Document
```

Or use the shortcut:

**Windows/Linux**

```text
Shift + Alt + F
```

**macOS**

```text
Shift + Option + F
```

---

# Enable Format on Save

To automatically format Terraform files whenever you save them:

1. Open **Settings**.
2. Search for:

```text
Format On Save
```

Enable:

```text
Editor: Format On Save
```

This keeps your Terraform code clean and consistent.

---

# Integrated Terminal

VS Code includes a built-in terminal.

Open it using:

```text
Ctrl + `
```

Or navigate to:

```text
Terminal → New Terminal
```

You can run commands such as:

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```

```bash
aws sts get-caller-identity
```

without leaving the editor.

---

# Verify Terraform Extension

Create a file named:

```text
main.tf
```

Add:

```hcl
terraform {
  required_version = ">= 1.5.0"
}
```

If the extension is installed correctly, you should notice:

- Syntax highlighting
- Auto-completion
- Hover documentation
- Code formatting support

---

# Using AWS Toolkit

After installation:

1. Open the AWS Toolkit panel.
2. Sign in using your configured AWS CLI profile.
3. Browse AWS resources such as:
   - Amazon S3
   - AWS Lambda
   - Amazon EC2
   - Amazon ECS
   - CloudWatch

The toolkit uses your configured AWS CLI credentials, making it easy to manage AWS resources directly from VS Code.

---

# ✅ Verification

Ensure the following:

- Visual Studio Code installed
- HashiCorp Terraform extension installed
- AWS Toolkit installed
- GitLens installed
- Error Lens installed
- YAML extension installed
- Terraform syntax highlighting works
- Auto-completion works
- Formatting works
- Integrated terminal opens successfully
- AWS Toolkit recognizes your AWS account

If all checks pass, your development environment is ready.

---

# ❗ Common Errors & Solutions

## Error: Terraform syntax highlighting not working

**Cause:**

The HashiCorp Terraform extension is not installed or enabled.

**Solution:**

Install or enable the official Terraform extension by HashiCorp.

---

## Error: Formatting does nothing

**Cause:**

Terraform is not installed or not available in your system's PATH.

**Solution:**

Run:

```bash
terraform version
```

If Terraform is not found, install it and restart VS Code.

---

## Error: AWS Toolkit cannot find credentials

**Cause:**

AWS CLI is not configured correctly.

**Solution:**

Verify your credentials:

```bash
aws sts get-caller-identity
```

If this command fails, reconfigure the AWS CLI using:

```bash
aws configure
```

---

## Error: IntelliSense not working

**Cause:**

The Terraform Language Server may not have initialized.

**Solution:**

Restart VS Code or reload the window using:

```text
Ctrl + Shift + P
```

Search for:

```text
Developer: Reload Window
```

---

## Error: Extensions fail to install

**Cause:**

Network connectivity issues or Marketplace access restrictions.

**Solution:**

- Verify your internet connection.
- Restart VS Code.
- Retry the installation.
- If you're behind a corporate proxy, configure VS Code's proxy settings.

---

# 💡 Best Practices

- Use the official **HashiCorp Terraform** extension.
- Keep VS Code and extensions updated.
- Enable **Format on Save** for consistent code formatting.
- Use the integrated terminal to run Terraform and AWS CLI commands.
- Commit your Infrastructure as Code to Git regularly.
- Avoid installing multiple Terraform extensions that provide overlapping functionality.
- Organize Terraform projects into separate workspaces or folders.
- Use Markdown extensions to maintain clear project documentation.

---

# 📚 Official Documentation

- Visual Studio Code  
  https://code.visualstudio.com/

- VS Code Marketplace  
  https://marketplace.visualstudio.com/vscode

- HashiCorp Terraform Documentation  
  https://developer.hashicorp.com/terraform/docs

- Terraform VS Code Extension  
  https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform

- AWS Toolkit for VS Code  
  https://docs.aws.amazon.com/toolkit-for-vscode/

- GitLens Documentation  
  https://help.gitkraken.com/gitlens/

---

# 🎉 What's Next

Congratulations! 🎉

You have successfully prepared your local development environment for Terraform and AWS development.

Your setup now includes:

- ✅ Terraform installed
- ✅ AWS CLI installed and configured
- ✅ AWS account secured
- ✅ IAM user created
- ✅ Visual Studio Code configured
- ✅ Essential extensions installed

You are now ready to begin writing your first Terraform configuration.

### Suggested Next Topics

1. Creating your first Terraform project
2. Understanding Terraform configuration files (`.tf`)
3. Terraform providers and resources
4. Variables and outputs
5. Terraform state management
6. `terraform init`, `plan`, `apply`, and `destroy`
7. Deploying your first AWS resource with Terraform
8. Best practices for Infrastructure as Code (IaC)

Happy Learning and Happy Terraforming! 🚀
