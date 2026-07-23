# AWS CLI Configuration

## 📖 Overview

After installing the AWS CLI and creating an IAM user with programmatic access, the next step is to configure the AWS CLI with your AWS credentials.

During configuration, you'll provide your **Access Key ID**, **Secret Access Key**, **default AWS Region**, and **output format**. These settings are stored locally and used to authenticate AWS CLI commands, Terraform, AWS SDKs, and many other AWS tools.

> **Important:** Configure the AWS CLI using an **IAM user**, not the Root User.

---

# 🎯 Objective

By the end of this guide, you will:

- Configure AWS CLI with your IAM credentials
- Understand where AWS credentials are stored
- Verify your AWS identity
- Test AWS CLI commands
- Learn how to manage multiple AWS profiles
- Follow AWS credential security best practices

---

# 🧠 What You'll Learn

After completing this guide, you'll be able to:

- Run the `aws configure` command
- Configure AWS credentials securely
- Set a default AWS Region
- Choose an output format
- Verify authentication using AWS STS
- Manage multiple AWS CLI profiles
- Locate and understand AWS configuration files

---

# 📋 Prerequisites

Before starting, ensure you have:

- AWS CLI Version 2 installed
- An active AWS account
- An IAM user with programmatic access
- Access Key ID
- Secret Access Key
- Terminal or Command Prompt access

---

# Understanding AWS CLI Configuration

AWS CLI stores configuration in two files:

### Credentials File

Stores:

- Access Key ID
- Secret Access Key

Typical location:

**Linux/macOS**

```text
~/.aws/credentials
```

**Windows**

```text
C:\Users\<username>\.aws\credentials
```

---

### Configuration File

Stores:

- Default Region
- Output format
- Named profiles

Typical location:

**Linux/macOS**

```text
~/.aws/config
```

**Windows**

```text
C:\Users\<username>\.aws\config
```

---

# 📝 Step-by-Step Instructions

## Step 1: Open a Terminal

Open your preferred terminal application.

Examples:

- Terminal (Linux/macOS)
- Windows Terminal
- PowerShell
- Command Prompt

---

## Step 2: Start AWS CLI Configuration

Run:

```bash
aws configure
```

AWS will prompt for the following information.

---

## Step 3: Enter Access Key ID

Example:

```text
AWS Access Key ID [None]:
AKIAIOSFODNN7EXAMPLE
```

Enter the **Access Key ID** generated during IAM user creation.

---

## Step 4: Enter Secret Access Key

Example:

```text
AWS Secret Access Key [None]:
wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

Paste your **Secret Access Key**.

> **Note:** The characters will not be visible while typing. This is normal.

---

## Step 5: Enter the Default AWS Region

Example:

```text
Default region name [None]:
ap-south-1
```

Common AWS Regions:

| Region | Code |
|--------|------|
| Mumbai | `ap-south-1` |
| Singapore | `ap-southeast-1` |
| Tokyo | `ap-northeast-1` |
| London | `eu-west-2` |
| Frankfurt | `eu-central-1` |
| North Virginia | `us-east-1` |
| Oregon | `us-west-2` |

Choose the region closest to your users or the one required for your project.

---

## Step 6: Choose the Output Format

Example:

```text
Default output format [None]:
json
```

Supported output formats:

- `json` (Recommended)
- `yaml`
- `yaml-stream`
- `text`
- `table`

For most users, **json** is the preferred choice because it is easy to read and works well with automation tools.

---

## Step 7: Verify Configuration Files

View the credentials file:

**Linux/macOS**

```bash
cat ~/.aws/credentials
```

**Windows PowerShell**

```powershell
type $HOME\.aws\credentials
```

Example:

```ini
[default]
aws_access_key_id = AKIAIOSFODNN7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

---

View the configuration file:

**Linux/macOS**

```bash
cat ~/.aws/config
```

**Windows PowerShell**

```powershell
type $HOME\.aws\config
```

Example:

```ini
[default]
region = ap-south-1
output = json
```

---

## Step 8: Verify Your Identity

Run:

```bash
aws sts get-caller-identity
```

Example output:

```json
{
  "UserId": "AIDAXXXXXXXXXXXXX",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/terraform-admin"
}
```

If this command succeeds, your AWS CLI is configured correctly.

---

## Step 9: Test AWS CLI

List Amazon S3 buckets:

```bash
aws s3 ls
```

If you don't have any buckets yet, the command may return no output. This is normal.

You can also list available AWS Regions:

```bash
aws ec2 describe-regions
```

---

# Working with Multiple AWS Profiles

If you manage multiple AWS accounts, create named profiles.

Example:

```bash
aws configure --profile development
```

Configure another profile:

```bash
aws configure --profile production
```

Use a profile:

```bash
aws s3 ls --profile development
```

Or set it as an environment variable:

**Linux/macOS**

```bash
export AWS_PROFILE=development
```

**Windows PowerShell**

```powershell
$env:AWS_PROFILE="development"
```

---

# Updating Configuration

To change your credentials or region, simply run:

```bash
aws configure
```

Or update a specific profile:

```bash
aws configure --profile development
```

---

# Removing Configuration

To remove AWS CLI configuration:

**Linux/macOS**

```bash
rm -rf ~/.aws
```

**Windows PowerShell**

```powershell
Remove-Item -Recurse -Force $HOME\.aws
```

> **Warning:** This removes all configured AWS profiles and credentials.

---

# ✅ Verification

Ensure the following checks are successful:

- AWS CLI configured without errors
- Credentials file created
- Config file created
- `aws sts get-caller-identity` returns your IAM user information
- `aws s3 ls` executes successfully
- Default Region configured
- Output format set to `json`

If all checks pass, your AWS CLI is fully configured.

---

# ❗ Common Errors & Solutions

## Error: Unable to locate credentials

**Cause:**

AWS CLI cannot find your credentials.

**Solution:**

Run:

```bash
aws configure
```

Or verify the contents of:

```text
~/.aws/credentials
```

---

## Error: InvalidClientTokenId

**Cause:**

The Access Key ID is incorrect or inactive.

**Solution:**

Verify the Access Key in the IAM Console or create a new one.

---

## Error: SignatureDoesNotMatch

**Cause:**

The Secret Access Key is incorrect.

**Solution:**

Reconfigure the AWS CLI with the correct credentials.

---

## Error: AccessDenied

**Cause:**

Your IAM user lacks the required permissions.

**Solution:**

Review the IAM policies attached to your user.

---

## Error: Could not connect to the endpoint URL

**Cause:**

Incorrect AWS Region or network connectivity issues.

**Solution:**

Verify the configured region and check your internet connection.

---

# 💡 Best Practices

- Always use IAM user credentials instead of Root User credentials.
- Store credentials only in the AWS CLI configuration files or use IAM roles when possible.
- Never hardcode Access Keys into source code.
- Never commit the `.aws` directory to Git repositories.
- Rotate Access Keys periodically.
- Use named profiles for managing multiple AWS accounts.
- Set the correct default region to avoid deploying resources unintentionally in another region.
- Verify your identity using `aws sts get-caller-identity` after any credential changes.

---

# 📚 Official Documentation

- AWS CLI Configuration Guide  
  https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

- AWS CLI User Guide  
  https://docs.aws.amazon.com/cli/latest/userguide/

- AWS STS Documentation  
  https://docs.aws.amazon.com/STS/latest/APIReference/

- AWS Regions and Endpoints  
  https://docs.aws.amazon.com/general/latest/gr/rande.html

- AWS CLI Command Reference  
  https://docs.aws.amazon.com/cli/latest/reference/

---

# 🎉 What's Next

Congratulations! Your local development environment is now fully configured to interact with AWS.

The next step is to prepare **Visual Studio Code** with the extensions that will make Terraform development easier and more productive.

➡️ **Next Guide:** `vscode-extensions.md`

In the next guide, you'll learn how to:

- Install Visual Studio Code extensions for Terraform
- Enable syntax highlighting and IntelliSense
- Improve code formatting and validation
- Configure helpful extensions for AWS and Git
- Build a productive Infrastructure as Code (IaC) development environment
