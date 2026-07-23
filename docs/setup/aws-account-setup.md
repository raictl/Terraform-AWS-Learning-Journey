# AWS Account Setup

## 📖 Overview

Before you can provision cloud infrastructure using Terraform or interact with AWS services through the AWS CLI, you need an AWS account. This guide walks you through creating a new AWS account, securing it with Multi-Factor Authentication (MFA), understanding the AWS Free Tier, and preparing the account for future projects.

> **Important:** The AWS account **Root User** has unrestricted access to all AWS services and resources. It should only be used for account-level tasks. For daily work, always use an IAM user.

---

# 🎯 Objective

By the end of this guide, you will:

- Create an AWS account
- Verify your email and payment information
- Understand the AWS Free Tier
- Secure your Root User with MFA
- Sign in to the AWS Management Console
- Prepare your account for IAM user creation

---

# 🧠 What You'll Learn

After completing this guide, you'll be able to:

- Create an AWS account from scratch
- Understand AWS account components
- Differentiate between Root User and IAM User
- Enable Multi-Factor Authentication (MFA)
- Access the AWS Management Console
- Follow AWS security best practices

---

# 📋 Prerequisites

Before starting, ensure you have:

- A valid email address
- A mobile phone for verification
- A credit/debit card (required by AWS, even for Free Tier accounts)
- A stable internet connection
- A web browser

> **Note:** AWS may temporarily authorize a small amount on your payment method during verification. This is typically refunded automatically.

---

# 📝 Step-by-Step Instructions

## Step 1: Visit the AWS Sign-Up Page

Open your web browser and navigate to:

https://aws.amazon.com/

Click **Create an AWS Account**.

---

## Step 2: Enter Account Information

Provide the following details:

- Email address
- AWS account name
- Password
- Confirm password

Click **Continue**.

> Use a professional email address that you will retain long-term.

---

## Step 3: Choose Account Type

Select the appropriate account type:

### Personal

Choose this if you're:

- Learning AWS
- Practicing Terraform
- Building personal projects

### Business

Choose this if you're:

- Representing a company
- Managing organizational resources

Click **Continue**.

---

## Step 4: Enter Contact Information

Provide:

- Full name
- Address
- City
- State/Province
- Postal code
- Country
- Phone number

Agree to the AWS Customer Agreement.

Click **Continue**.

---

## Step 5: Add Payment Information

Enter your:

- Credit card or debit card details
- Billing address (if different)

AWS uses this information to:

- Verify your identity
- Charge for resources used beyond the Free Tier

Click **Verify and Continue**.

---

## Step 6: Phone Verification

AWS will request:

- Country code
- Phone number

Choose:

- SMS
- Voice call

Enter the verification code you receive.

---

## Step 7: Choose a Support Plan

AWS offers several support plans.

For beginners, select:

**Basic Support (Free)**

This includes:

- Customer service
- Documentation
- AWS Trusted Advisor (limited)
- Billing support

Click **Complete Sign Up**.

---

## Step 8: Wait for Account Activation

AWS will verify your information and activate your account.

This process usually takes:

- A few minutes
- Up to 24 hours in some cases

You'll receive a confirmation email once your account is active.

---

## Step 9: Sign In to the AWS Management Console

Go to:

https://console.aws.amazon.com/

Sign in as the **Root User** using:

- Your registered email address
- Your password

You should now see the AWS Management Console.

---

# Understanding the AWS Free Tier

The AWS Free Tier provides limited free usage of many AWS services for new accounts.

Examples include:

- Amazon EC2
- Amazon S3
- AWS Lambda
- Amazon DynamoDB
- Amazon RDS

> **Important:** Free Tier has usage limits. Exceeding those limits may result in charges.

Always monitor your AWS Billing Dashboard.

---

# Secure Your Root User

The Root User has full administrative access to your AWS account.

AWS recommends:

- Never use the Root User for daily work.
- Create IAM users for regular access.
- Enable MFA immediately.

---

## Step 10: Enable Multi-Factor Authentication (MFA)

While signed in as the Root User:

1. Click your account name (top-right corner).
2. Select **Security credentials**.
3. Locate **Multi-factor authentication (MFA)**.
4. Click **Assign MFA device**.

Choose one of the following:

- Authenticator App (Recommended)
- Security Key
- Hardware MFA Device

Popular authenticator apps include:

- Google Authenticator
- Microsoft Authenticator
- Authy

Follow the on-screen instructions to scan the QR code and enter two consecutive verification codes.

Click **Add MFA**.

---

# Billing Dashboard

To monitor your AWS usage:

1. Open the AWS Console.
2. Search for **Billing and Cost Management**.
3. Open the Billing Dashboard.

Here you can:

- View current charges
- Track Free Tier usage
- Download invoices
- Set budgets
- Monitor cost trends

---

# Recommended Initial Security Settings

After account creation:

- Enable MFA
- Create an IAM user
- Avoid using the Root User for daily tasks
- Use strong, unique passwords
- Monitor billing regularly

---

# ✅ Verification

Confirm the following:

- AWS account created successfully
- Email verified
- Payment method added
- Phone verification completed
- Basic Support selected
- Successfully signed in to the AWS Console
- MFA enabled for the Root User

If all the above are complete, your AWS account is ready for use.

---

# ❗ Common Errors & Solutions

## Error: Verification email not received

**Solution:**

- Check your Spam/Junk folder.
- Ensure the email address is correct.
- Wait a few minutes and retry if necessary.

---

## Error: Payment method declined

**Solution:**

- Verify card details.
- Ensure online/international transactions are enabled.
- Contact your bank if the issue persists.

---

## Error: Account activation delayed

**Solution:**

Account verification can occasionally take up to 24 hours. Monitor your email for updates from AWS.

---

## Error: Cannot sign in

**Solution:**

- Ensure you're signing in as the **Root User**.
- Use the email address registered during sign-up.
- Reset your password if necessary.

---

## Error: Unexpected charges

**Solution:**

- Review your AWS Billing Dashboard.
- Ensure your resource usage stays within Free Tier limits.
- Delete unused resources promptly.

---

# 💡 Best Practices

- Enable MFA immediately after account creation.
- Never share your Root User credentials.
- Use the Root User only for account-level tasks.
- Create IAM users for daily administration.
- Enable billing alerts and budgets.
- Monitor Free Tier usage regularly.
- Delete unused resources to avoid unexpected charges.
- Read pricing information before launching new services.

---

# 📚 Official Documentation

- AWS Home  
  https://aws.amazon.com/

- AWS Sign-Up Guide  
  https://aws.amazon.com/free/

- AWS Free Tier  
  https://aws.amazon.com/free/

- AWS Account Management  
  https://docs.aws.amazon.com/accounts/

- AWS Billing Documentation  
  https://docs.aws.amazon.com/awsaccountbilling/

- AWS Multi-Factor Authentication (MFA)  
  https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa.html

---

# 🎉 What's Next

Your AWS account is now ready and secured.

The next step is to create an IAM user for daily administration and CLI access.

➡️ **Next Guide:** `iam-user-creation.md`

In the next guide, you'll learn how to:

- Create an IAM user
- Assign permissions
- Generate Access Keys
- Understand IAM policies
- Follow AWS security best practices
- Prepare your account for AWS CLI configuration
