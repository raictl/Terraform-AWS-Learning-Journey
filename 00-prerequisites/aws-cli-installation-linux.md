# AWS CLI Installation on Linux

## 📖 Overview

The AWS Command Line Interface (AWS CLI) is an open-source tool that enables you to interact with AWS services directly from your terminal. Instead of using the AWS Management Console for every operation, you can execute AWS commands, automate repetitive tasks, and integrate AWS operations into scripts and CI/CD pipelines.

AWS CLI Version 2 is the latest recommended version and includes all the features required for modern AWS development.

---

# 🎯 Objective

By the end of this guide, you will:

- Install AWS CLI Version 2 on a Linux machine
- Verify the installation
- Understand how AWS CLI works
- Prepare your system for Terraform and future AWS projects

---

# 🧠 What You'll Learn

After completing this guide, you'll be able to:

- Download AWS CLI Version 2
- Install AWS CLI using the official installer
- Check the installed version
- Understand where AWS CLI is installed
- Update AWS CLI in the future
- Remove AWS CLI if needed

---

# 📋 Prerequisites

Before starting, ensure you have:

- A Linux machine (Ubuntu, Debian, Fedora, CentOS, Amazon Linux, etc.)
- Terminal access
- Internet connection
- sudo privileges
- `curl` or `wget`
- `unzip` package installed

To install unzip (if not already installed):

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install unzip -y
```

### Fedora

```bash
sudo dnf install unzip -y
```

### CentOS/RHEL

```bash
sudo yum install unzip -y
```

---

# 📝 Step-by-Step Instructions

## Step 1: Check Whether AWS CLI Is Already Installed

Open Terminal and run:

```bash
aws --version
```

If AWS CLI is already installed, you'll see output similar to:

```text
aws-cli/2.31.0 Python/3.13 Linux/x86_64
```

If you receive:

```text
command not found
```

continue with the installation.

---

## Step 2: Download AWS CLI Version 2

For 64-bit Linux systems:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

Or using wget:

```bash
wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
```

---

## Step 3: Extract the Installer

```bash
unzip awscliv2.zip
```

This creates a directory named:

```text
aws/
```

---

## Step 4: Run the Installer

Execute:

```bash
sudo ./aws/install
```

Expected output:

```text
You can now run:
/usr/local/bin/aws --version
```

---

## Step 5: Verify the Installation

Run:

```bash
aws --version
```

Example output:

```text
aws-cli/2.31.0 Python/3.13 Linux/x86_64 source/x86_64
```

Congratulations! AWS CLI is successfully installed.

---

# Understanding the Installation

The installer places files in:

Executable:

```text
/usr/local/bin/aws
```

Program files:

```text
/usr/local/aws-cli/
```

Verify the executable path:

```bash
which aws
```

Expected:

```text
/usr/local/bin/aws
```

---

# Updating AWS CLI

Download the latest installer:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

Extract it:

```bash
unzip awscliv2.zip
```

Run the update:

```bash
sudo ./aws/install --update
```

Verify:

```bash
aws --version
```

---

# Uninstalling AWS CLI

Remove the installation:

```bash
sudo rm -rf /usr/local/aws-cli
```

Remove the executable:

```bash
sudo rm /usr/local/bin/aws
```

Verify:

```bash
aws --version
```

Expected:

```text
command not found
```

---

# Troubleshooting PATH Issues

If `aws --version` doesn't work after installation:

Check the executable location:

```bash
which aws
```

If nothing is returned, verify that `/usr/local/bin` is in your PATH:

```bash
echo $PATH
```

If needed, temporarily add it:

```bash
export PATH=$PATH:/usr/local/bin
```

To make it permanent, add the following line to your shell configuration file (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
export PATH=$PATH:/usr/local/bin
```

Reload the shell:

```bash
source ~/.bashrc
```

or

```bash
source ~/.zshrc
```

---

# Multiple CPU Architectures

### Intel/AMD (x86_64)

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

### ARM64 (Graviton, Raspberry Pi, Apple Linux VMs)

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
```

Check your architecture:

```bash
uname -m
```

Output:

```text
x86_64
```

or

```text
aarch64
```

---

# ✅ Verification

Confirm each step below:

### AWS CLI Installed

```bash
aws --version
```

### AWS Executable Exists

```bash
which aws
```

### Installation Directory Exists

```bash
ls /usr/local/aws-cli
```

### Binary Works

```bash
aws help
```

If all commands execute successfully, the installation is complete.

---

# ❗ Common Errors & Solutions

## Error: command not found

**Cause**

AWS CLI is not installed or not available in the PATH.

**Solution**

Verify installation:

```bash
which aws
```

If needed, add:

```bash
export PATH=$PATH:/usr/local/bin
```

---

## Error: unzip: command not found

Install unzip.

Ubuntu/Debian:

```bash
sudo apt install unzip -y
```

Fedora:

```bash
sudo dnf install unzip -y
```

CentOS:

```bash
sudo yum install unzip -y
```

---

## Error: Permission denied

Run the installer with sudo:

```bash
sudo ./aws/install
```

---

## Error: curl not found

Ubuntu:

```bash
sudo apt install curl -y
```

Fedora:

```bash
sudo dnf install curl -y
```

CentOS:

```bash
sudo yum install curl -y
```

---

## Error: aws: No such file or directory

The installation may have failed or the executable path is incorrect.

Reinstall AWS CLI following the installation steps.

---

# 💡 Best Practices

- Always install AWS CLI Version 2.
- Download AWS CLI only from the official AWS website.
- Keep AWS CLI updated to access the latest features and security fixes.
- Avoid installing AWS CLI through unofficial package repositories unless required by your organization.
- Verify your installation after every update.
- Learn basic AWS CLI commands before using automation tools like Terraform.
- Do not store AWS credentials directly in scripts or source code.

---

# 📚 Official Documentation

- AWS CLI User Guide  
  https://docs.aws.amazon.com/cli/latest/userguide/

- AWS CLI Version 2 Installation  
  https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

- AWS CLI Command Reference  
  https://docs.aws.amazon.com/cli/latest/reference/

---

# 🎉 What's Next

Now that AWS CLI is installed, you're ready to create and configure your AWS account.

Continue with:

➡️ **aws-account-setup.md**

In the next guide, you'll learn how to:

- Create an AWS account
- Secure your root user
- Enable Multi-Factor Authentication (MFA)
- Understand AWS Free Tier
- Sign in to the AWS Management Console
- Prepare your account for Terraform and AWS CLI usage
