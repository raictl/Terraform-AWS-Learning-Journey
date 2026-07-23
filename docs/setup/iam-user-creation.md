# IAM User Creation

## 📖 Overview

AWS recommends **never using the Root User for day-to-day activities**. Instead, create an **IAM (Identity and Access Management) User** with the required permissions. IAM allows you to securely manage access to AWS resources by creating users, groups, roles, and policies.

In this guide, you'll create an IAM user with administrative permissions and generate Access Keys that will be used to configure the AWS CLI in the next guide.

> **Important:** For learning and personal projects, an IAM user with administrative permissions is acceptable. In production environments, always follow the **Principle of Least Privilege** by granting only the permissions required.

---

# 🎯 Objective

By the end of this guide, you will:

- Understand AWS IAM
- Create an IAM user
- Assign appropriate permissions
- Enable AWS Management Console access
- Generate Access Keys for AWS CLI
- Securely download and store user credentials

---

# 🧠 What You'll Learn

After completing this guide, you'll be able to:

- Differentiate between Root User and IAM User
- Create IAM users
- Assign permissions using AWS managed policies
- Create programmatic access credentials
- Understand Access Key ID and Secret Access Key
- Follow IAM security best practices

---

# 📋 Prerequisites

Before starting, ensure you have:

- An active AWS account
- Root User access (for initial IAM setup)
- Multi-Factor Authentication (MFA) enabled on the Root User
- Access to the AWS Management Console

---

# Understanding IAM

**AWS Identity and Access Management (IAM)** is a service that allows you to securely control access to AWS resources.

With IAM, you can:

- Create users
- Create groups
- Assign permissions
- Create roles
- Control access to AWS services

---

# Root User vs IAM User

| Feature | Root User | IAM User |
|---------|-----------|----------|
| Created during account setup | ✅ | ❌ |
| Full account access | ✅ | Depends on permissions |
| Recommended for daily work | ❌ | ✅ |
| Can create other users | ✅ | If permitted |
| Should enable MFA | ✅ | ✅ |
| Used for billing tasks | ✅ | Optional |

> **Best Practice:** Use the Root User only for account-level tasks such as billing, payment methods, or account settings.

---

# 📝 Step-by-Step Instructions

## Step 1: Sign In as the Root User

Open:

https://console.aws.amazon.com/

Sign in using:

- Root User email
- Password
- MFA code

---

## Step 2: Open IAM

In the AWS Management Console:

1. Search for **IAM** in the search bar.
2. Select **IAM** from the services list.

You will be taken to the IAM Dashboard.

---

## Step 3: Navigate to Users

In the left navigation pane:

**Users → Create user**

---

## Step 4: Enter User Details

Provide:

**User name**

Example:

```text
terraform-admin
```

### AWS Management Console Access

Enable:

✅ **Provide user access to the AWS Management Console**

Choose:

- **I want to create an IAM user**

Allow AWS to generate a console password or set a custom password.

Optionally, require the user to create a new password at first sign-in.

Click **Next**.

---

## Step 5: Set Permissions

Choose:

**Attach policies directly**

Search for:

```text
AdministratorAccess
```

Select:

✅ **AdministratorAccess**

> **Note:** This policy grants full administrative permissions. It is suitable for learning environments but should be avoided for production users unless absolutely necessary.

Click **Next**.

---

## Step 6: Review and Create User

Review the configuration:

- User name
- Console access
- Permissions

Click:

**Create user**

AWS will create the IAM user.

---

## Step 7: Retrieve Sign-In Information

After the user is created, note the following:

- IAM user sign-in URL
- User name

Example sign-in URL:

```text
https://123456789012.signin.aws.amazon.com/console
```

Save this URL for future logins.

---

## Step 8: Generate Access Keys

To allow programmatic access (AWS CLI, Terraform, SDKs):

1. In IAM, select the newly created user.
2. Open the **Security credentials** tab.
3. Scroll to **Access keys**.
4. Click **Create access key**.

---

## Step 9: Choose Use Case

AWS asks how the access key will be used.

Select:

**Command Line Interface (CLI)**

Acknowledge the recommendation and continue.

---

## Step 10: Create Access Key

Click:

**Create access key**

AWS displays:

- **Access Key ID**
- **Secret Access Key**

> **Important:** The **Secret Access Key is displayed only once**. Save it securely before leaving the page.

---

## Step 11: Download the Credentials

Click:

**Download .csv file**

Store the file securely.

The CSV file typically contains:

```text
User Name
Access Key ID
Secret Access Key
Console Sign-In URL
```

Do **not** commit this file to Git repositories or share it with others.

---

# Understanding Access Keys

AWS provides two values:

### Access Key ID

A public identifier used to identify the IAM user.

Example:

```text
AKIAIOSFODNN7EXAMPLE
```

### Secret Access Key

A private key used to authenticate requests.

Example:

```text
wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

> Treat the Secret Access Key like a password. Anyone with both values can access your AWS account according to the permissions granted.

---

# Managing Access Keys

If an Access Key is lost or compromised:

1. Go to **IAM → Users**.
2. Select the user.
3. Open **Security credentials**.
4. Deactivate or delete the compromised key.
5. Create a new Access Key.

Never reuse compromised credentials.

---

# ✅ Verification

Verify the following:

- IAM user created successfully
- AdministratorAccess policy attached
- Console sign-in enabled
- IAM sign-in URL saved
- Access Key ID generated
- Secret Access Key saved securely
- Credentials CSV downloaded

If all items are complete, the IAM user is ready for AWS CLI configuration.

---

# ❗ Common Errors & Solutions

## Error: Cannot create user

**Cause:**

Insufficient permissions.

**Solution:**

Sign in as the Root User or an IAM user with IAM administrative permissions.

---

## Error: Secret Access Key lost

**Solution:**

AWS does not allow viewing the Secret Access Key again.

Delete the old Access Key and create a new one.

---

## Error: Access denied after login

**Solution:**

Verify that the correct IAM user credentials are being used and that the required permissions have been assigned.

---

## Error: Access Key inactive

**Solution:**

Navigate to:

IAM → Users → Security credentials → Access keys

Ensure the key status is **Active**.

---

## Error: Forgot IAM sign-in URL

**Solution:**

From the AWS Management Console:

IAM Dashboard → AWS Account → IAM users sign-in link

Save the URL for future use.

---

# 💡 Best Practices

- Never use the Root User for daily work.
- Enable MFA for IAM users whenever possible.
- Follow the Principle of Least Privilege.
- Rotate Access Keys regularly.
- Delete unused IAM users and Access Keys.
- Never hardcode Access Keys into source code.
- Never upload credential files to GitHub or any public repository.
- Use IAM groups and roles for managing permissions in larger environments.

---

# 📚 Official Documentation

- AWS IAM Documentation  
  https://docs.aws.amazon.com/IAM/

- IAM User Guide  
  https://docs.aws.amazon.com/IAM/latest/UserGuide/

- Creating IAM Users  
  https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html

- IAM Best Practices  
  https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html

- Managing Access Keys  
  https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html

---

# 🎉 What's Next

Your IAM user is now ready for programmatic access.

In the next guide, you'll configure the AWS CLI using the Access Key ID and Secret Access Key you created.

➡️ **Next Guide:** `aws-cli-configuration.md`

In the next guide, you'll learn how to:

- Configure AWS CLI credentials
- Set the default AWS Region
- Verify your identity using AWS STS
- Test AWS CLI commands
- Understand where credentials are stored
- Secure your local AWS configuration
