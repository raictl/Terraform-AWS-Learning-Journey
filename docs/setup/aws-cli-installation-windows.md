# Install AWS CLI on Windows

> A complete step-by-step guide to installing and configuring the AWS Command Line Interface (AWS CLI) on Windows.

---

# 📖 Overview

The **AWS Command Line Interface (AWS CLI)** is a command-line tool provided by Amazon Web Services (AWS). It allows you to interact with AWS services directly from your terminal without using the AWS Management Console.

The AWS CLI is widely used by DevOps Engineers, Cloud Engineers, and Automation Engineers to manage AWS resources, automate tasks, and integrate AWS operations into scripts and CI/CD pipelines.

---

# 🎯 Objective

By the end of this guide, you will be able to:

* Understand what AWS CLI is.
* Install AWS CLI on Windows.
* Verify that AWS CLI is installed correctly.
* Understand the basic AWS CLI commands.
* Prepare your system for Terraform and AWS automation.

---

# 🧠 What You'll Learn

* What AWS CLI is
* Downloading AWS CLI
* Installing AWS CLI
* Verifying the installation
* Checking the installed version
* Understanding basic AWS CLI commands

---

# 📋 Prerequisites

Before starting, ensure you have:

* Windows 10 or Windows 11
* Administrator privileges (recommended)
* Internet connection
* Command Prompt or PowerShell

---

# 📝 Step 1 — Download AWS CLI

Open your web browser.

Visit the official AWS CLI download page:

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Download the **AWS CLI MSI Installer for Windows (64-bit)**.

Example:

```
AWSCLIV2.msi
```

> **Note**
>
> Always download AWS CLI from the official AWS documentation.

---

# 📝 Step 2 — Run the Installer

Locate the downloaded file.

Example:

```
Downloads
│
└── AWSCLIV2.msi
```

Double-click the installer.

The installation wizard will open.

Click:

```
Next
```

Accept the license agreement.

Click:

```
Next
```

Click:

```
Install
```

If Windows asks for permission, click:

```
Yes
```

Wait until the installation finishes.

Click:

```
Finish
```

---

# 📝 Step 3 — Verify Installation

Open a new Command Prompt.

Run:

```bash
aws --version
```

Expected output:

```text
aws-cli/2.x.x Python/3.x.x Windows/AMD64 exe
```

Congratulations!

AWS CLI has been installed successfully.

---

# 📝 Step 4 — Check Installation Path

Run:

```bash
where aws
```

Expected output:

```text
C:\Program Files\Amazon\AWSCLIV2\aws.exe
```

This confirms that Windows can locate the AWS CLI executable.

---

# 📝 Step 5 — Display AWS CLI Help

Run:

```bash
aws help
```

You should see the AWS CLI help page containing available services and commands.

---

# 📝 Step 6 — Check the Installed Version

Run:

```bash
aws --version
```

Example:

```text
aws-cli/2.27.0 Python/3.13 Windows/AMD64 exe
```

Your version may differ depending on the latest AWS CLI release.

---

# 📝 Step 7 — Test the AWS CLI

Run:

```bash
aws
```

AWS CLI should display a list of available commands instead of an error.

This confirms the installation is working correctly.

---

# 📌 What You Can Do with AWS CLI

Using AWS CLI, you can:

* Create EC2 instances
* Manage S3 buckets
* Create IAM users
* Launch VPC resources
* Upload files to S3
* Configure CloudWatch
* Manage Route53
* Work with ECS and EKS
* Automate AWS operations using scripts

---

# ✅ Verification Checklist

Verify the following:

* [ ] AWS CLI downloaded successfully
* [ ] Installer completed successfully
* [ ] `aws --version` works
* [ ] `where aws` displays the executable path
* [ ] `aws help` opens successfully
* [ ] No installation errors occurred

---

# ❗ Common Errors and Solutions

## Error

```
'aws' is not recognized as an internal or external command
```

### Cause

AWS CLI is not installed correctly or the terminal has not been restarted.

### Solution

* Close Command Prompt.
* Open a new Command Prompt.
* Verify installation.
* If needed, reinstall AWS CLI.

---

## Error

```
Access is denied
```

### Cause

Insufficient permissions.

### Solution

Run the installer as Administrator.

---

## Error

```
aws.exe not found
```

### Cause

Installation failed.

### Solution

Reinstall AWS CLI using the official installer.

---

## Error

```
The system cannot find the file specified
```

### Cause

Installation is incomplete.

### Solution

Uninstall AWS CLI.

Download the latest installer.

Install it again.

---

# 💡 Best Practices

* Download AWS CLI only from the official AWS website.
* Keep AWS CLI updated.
* Restart your terminal after installation.
* Never share AWS Access Keys publicly.
* Rotate AWS credentials regularly.
* Use IAM Users instead of the AWS Root Account for daily work.
* Configure MFA for your AWS account.

---

# 📚 Frequently Used AWS CLI Commands

| Command                       | Description                  |
| ----------------------------- | ---------------------------- |
| `aws --version`               | Display installed version    |
| `aws help`                    | Display CLI help             |
| `aws configure`               | Configure AWS credentials    |
| `aws s3 ls`                   | List S3 buckets              |
| `aws ec2 describe-instances`  | List EC2 instances           |
| `aws iam list-users`          | List IAM users               |
| `aws sts get-caller-identity` | Display current AWS identity |

---

# 📚 Official Documentation

## AWS CLI User Guide

https://docs.aws.amazon.com/cli/latest/userguide/

---

## AWS CLI Installation Guide

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

---

## AWS CLI Command Reference

https://docs.aws.amazon.com/cli/latest/reference/

---

# 🎉 What's Next?

Now that AWS CLI is installed, continue with the next setup guides:

* Install AWS CLI on Linux
* Create an AWS Account
* Create an IAM User
* Configure AWS CLI (`aws configure`)
* Verify your AWS credentials
* Deploy your first AWS resource using Terraform

---

Happy Learning! 🚀

