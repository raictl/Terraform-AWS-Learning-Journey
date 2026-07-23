# Terraform Best Practices ✅

## 📖 Overview
Anyone can write a `.tf` file that works once. This guide covers the habits that make Terraform code maintainable, safe, and readable by someone other than you six months from now — the difference between a learning script and something you'd actually trust in production.

## 🎯 Objective
Build the instincts to structure, name, and manage Terraform projects the way experienced teams do, so your portfolio code reads as production-grade to anyone reviewing it (including interviewers).

## 🧠 What you'll learn
- How to structure files and directories in a real project
- Naming conventions that make code self-documenting
- Variable and output design
- Module design principles
- CI/CD and review habits
- Common anti-patterns to avoid

## 📝 Step-by-step instructions

### 1. File structure
A conventional root module layout, even for small projects:
```
project/
├── main.tf          # primary resources
├── variables.tf      # input variable declarations
├── outputs.tf         # output declarations
├── providers.tf       # provider + required_providers blocks
├── versions.tf         # terraform { required_version } block
├── terraform.tfvars    # actual values (gitignored if sensitive)
└── modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

📸 *Screenshot placeholder: VS Code file tree showing this structure*

Splitting by *purpose* (variables vs. outputs vs. resources) rather than dumping everything in one `main.tf` is what makes a stranger able to navigate your repo in under a minute.

### 2. Naming conventions
- Resource names: `snake_case`, descriptive, no redundant prefixes — `aws_instance.web` not `aws_instance.aws_instance_web`.
- Variable names: describe the *what*, not the *type* — `instance_type` not `instance_type_string`.
- Always add `description` to every variable and output. Future-you (and interviewers reading your code) will thank you.

```hcl
variable "instance_type" {
  description = "EC2 instance type for the web tier (e.g. t3.micro)"
  type        = string
  default     = "t3.micro"
}
```

### 3. Pin your versions
Unpinned providers are the #1 cause of "it worked yesterday" bugs.

```hcl
terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```
Commit the generated `.terraform.lock.hcl` to git — it locks exact provider versions across your whole team.

### 4. Design modules around a single responsibility
A good module does one clear thing (e.g. "a VPC," "an EKS cluster") and exposes a small, intentional set of inputs/outputs. If a module has 40 variables, it's probably doing too much.

```hcl
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  az_count   = 3
}
```

📸 *Screenshot placeholder: diagram of root module calling child modules (vpc, eks, rds)*

### 5. Use `tfvars` per environment, not hardcoded values
```
dev.tfvars
staging.tfvars
prod.tfvars
```
```bash
terraform apply -var-file="prod.tfvars"
```
This keeps environment differences explicit and reviewable in a diff, rather than buried in conditional logic.

### 6. Tag everything
Consistent tagging isn't optional in a real AWS account — it's how cost allocation, ownership, and cleanup automation work.
```hcl
tags = {
  Project     = "k8s-stress-lab"
  Environment = terraform.workspace
  ManagedBy   = "terraform"
}
```
Consider a shared `locals` block or `default_tags` on the AWS provider so you don't repeat this on every resource.

### 7. CI/CD hygiene
- Run `terraform fmt -check` and `terraform validate` on every pull request.
- Run `terraform plan` in CI and post the output as a PR comment for human review before merge.
- Only run `terraform apply` from a protected branch (e.g. `main`), never from a feature branch.
- Use a scanning tool (like Trivy or Checkov) on your `.tf` files in CI to catch misconfigurations before they ever reach `apply`.

📸 *Screenshot placeholder: GitHub Actions workflow showing fmt → validate → plan → (manual approval) → apply stages*

## ✅ Verification
- `terraform fmt -check` passes with no output (nothing needed reformatting)
- `terraform validate` returns `Success!`
- Every variable and output in your repo has a `description`
- `git log` shows meaningful, incremental commits rather than one giant "final version" commit — this matters for anyone reviewing your portfolio history

## ❗ Common errors and fixes

| Error / smell | Cause | Fix |
|---|---|---|
| One giant `main.tf` with 500+ lines | No file separation by purpose | Split into `variables.tf`, `outputs.tf`, `providers.tf` |
| Hardcoded AMI IDs, CIDR blocks, account IDs | Values typed directly into resource blocks | Move to variables with sensible defaults |
| `terraform plan` shows unexpected diffs every run | Provider computes a value differently than your config expects (drift) | Check provider docs for computed vs. required attributes; consider `ignore_changes` in a `lifecycle` block for genuinely externally-managed attributes |
| Secrets visible in `git log` | Committed a `.tfvars` file with real credentials | Rotate the leaked secret immediately, then add `*.tfvars` (except examples) to `.gitignore` going forward |
| Module with 30+ input variables | Module doing too many unrelated things | Split into smaller, focused modules |

## 💡 Best practices
- Small, frequent commits with clear messages beat one large "final" commit — especially for a portfolio repo where reviewers look at your git history.
- Write a README for every module explaining its purpose, inputs, and outputs — treat modules as if a stranger will use them without asking you questions.
- Prefer explicit values over "magic" defaults that only make sense if you already know the context.
- Run `terraform plan` and actually read it — don't rubber-stamp `apply` out of habit.

## 🛡️ Security tips
- Never commit real AWS credentials, `.pem` keys, or `.tfvars` files containing secrets to git — use `.gitignore` proactively, not reactively.
- Use least-privilege IAM policies scoped to exactly what Terraform needs to create/manage — avoid attaching `AdministratorAccess` to CI service accounts.
- Enable `encrypt = true` on remote state backends and restrict access via bucket policy (see `terraform-state.md`).
- Use tools like Trivy, Checkov, or tfsec in CI to catch security misconfigurations (open security groups, unencrypted volumes) before merge.
- Never mark sensitive outputs without the `sensitive = true` flag, so values don't leak into CLI logs:
```hcl
output "db_password" {
  value     = aws_db_instance.main.password
  sensitive = true
}
```

## 📚 Official documentation links
- [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/style)
- [Module Development Overview](https://developer.hashicorp.com/terraform/language/modules/develop)
- [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
- [Terraform Cloud/CI Best Practices](https://developer.hashicorp.com/terraform/tutorials/automation)

## 🎉 What's next
You've now got the full picture: commands, state, workspaces, and best practices. A great next step for your portfolio repo is applying all four docs to one real module (e.g. a VPC or EC2 module) end-to-end, then documenting the process with real screenshots in place of the placeholders above — that's what will make the repo genuinely useful to other learners, not just a personal notes dump.
