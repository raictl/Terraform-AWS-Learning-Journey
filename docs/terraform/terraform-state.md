# Terraform State 🗂️

## 📖 Overview
State is the single most misunderstood part of Terraform for beginners. It's a JSON file (`terraform.tfstate`) that maps your `.tf` configuration to real-world resources. Without it, Terraform would have no idea which AWS instance corresponds to which `resource` block in your code — it would have to guess, every single time.

## 🎯 Objective
Understand what state is, why it exists, how to inspect and safely modify it, and how to store it somewhere better than your laptop's hard drive.

## 🧠 What you'll learn
- What the state file actually contains and why Terraform needs it
- The difference between local and remote state
- State locking and why it prevents disasters
- The `terraform state` subcommands for inspecting and surgically fixing state
- Common state problems and how to recover from them

## 📝 Step-by-step instructions

### 1. What state actually is
Think of state as Terraform's "memory." Your `.tf` files describe the *desired* end result ("I want one EC2 instance of type t3.micro"). AWS knows the *actual* current world. State is the bridge that lets Terraform answer: "the instance I created last week for this exact resource block has ID `i-0abc123`."

Without that mapping, every `plan` would have to either recreate everything from scratch or try to reverse-engineer which real resources match your code — which is unreliable and dangerous.

📸 *Screenshot placeholder: diagram showing .tf config ↔ state file ↔ real AWS resources*

### 2. Local state (the default)
By default, `terraform init` sets up a **local backend**, meaning `terraform.tfstate` is just a file sitting next to your `.tf` files.

```bash
ls -la
# .terraform/
# terraform.tfstate
# terraform.tfstate.backup
```

This works fine for solo learning projects but breaks down fast in a team: if two people apply changes independently, their local state files diverge and Terraform loses track of reality.

### 3. Remote state (the real-world setup)
For anything beyond solo experiments, store state remotely — commonly in an S3 bucket, with a DynamoDB table for locking. This is configured in a `backend` block:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

After adding or changing a backend block, re-run:
```bash
terraform init -migrate-state
```

📸 *Screenshot placeholder: S3 bucket console showing the terraform.tfstate object*

### 4. State locking
When someone runs `apply`, Terraform acquires a **lock** (via DynamoDB, if you're using the S3 backend) so nobody else can run `apply` at the same time and corrupt the state. Think of it like a "file is being edited" flag — it stops two people from stepping on each other.

If Terraform crashes mid-apply, the lock can get stuck. You'll see:
```
Error acquiring the state lock
```
Only force-unlock after you've confirmed (with your team) that no `apply` is actually still running:
```bash
terraform force-unlock <LOCK_ID>
```

### 5. Inspecting state with `terraform state`
```bash
# List every resource Terraform is tracking
terraform state list

# Show full details of one resource
terraform state show aws_instance.web
```

📸 *Screenshot placeholder: `terraform state list` output showing multiple resources*

### 6. Moving and removing resources in state
Sometimes you rename a resource in your `.tf` file, but you don't want Terraform to destroy the old one and create a new one — you just want to tell it "this is the same resource, new name."

```bash
terraform state mv aws_instance.old_name aws_instance.new_name
```

To tell Terraform to stop managing a resource *without* deleting it in AWS (useful if you're handing it off to another team or tool):
```bash
terraform state rm aws_instance.web
```

### 7. Importing existing infrastructure
If a resource already exists in AWS (created manually or by another tool) and you want Terraform to manage it going forward:
```bash
terraform import aws_instance.web i-0abc123456
```
You still need a matching `resource` block written in your `.tf` file first — `import` only populates state, it does not generate configuration for you.

## ✅ Verification
- `terraform state list` shows the resource you expect
- `terraform plan` shows **no changes** for a resource you just imported or moved (if it shows changes, your `.tf` config doesn't quite match reality yet — adjust it)
- For remote state, confirm the object exists in your S3 bucket console

## ❗ Common errors and fixes

| Error | Cause | Fix |
|---|---|---|
| `Error: Backend configuration changed` | Backend block edited but not re-initialized | `terraform init -reconfigure` or `-migrate-state` |
| `Resource already exists` on apply | Resource exists in AWS but not in Terraform state | Use `terraform import` instead of `apply` |
| State file shows resources that no longer exist in AWS | Manual deletion outside Terraform | Run `terraform refresh` (or `terraform apply -refresh-only`) to sync state with reality |
| Merge conflicts in `terraform.tfstate` in git | State file was committed to version control | **Never commit state to git** — migrate to a remote backend immediately |
| `Error acquiring the state lock` | Stuck lock from a crashed run | Confirm no other apply is running, then `terraform force-unlock <ID>` |

## 💡 Best practices
- Never edit `terraform.tfstate` by hand — always use `terraform state` subcommands.
- Never commit `.tfstate` files to git, even in a private repo.
- Use remote state (S3 + DynamoDB, or Terraform Cloud) as soon as more than one person touches a project.
- Run `terraform plan` after any `state mv` or `import` to confirm Terraform now sees "no changes."

## 🛡️ Security tips
- State files often contain **plaintext secrets** (database passwords, private keys) as resource attributes — treat the state file itself as sensitive data.
- Enable encryption at rest on your S3 state bucket (`encrypt = true`) and restrict bucket access via IAM policy.
- Enable S3 bucket versioning on your state bucket so you can recover from accidental corruption or bad applies.
- Restrict who can run `terraform apply` in CI — anyone with apply access effectively has access to everything in state.

## 📚 Official documentation links
- [Terraform State Overview](https://developer.hashicorp.com/terraform/language/state)
- [S3 Backend](https://developer.hashicorp.com/terraform/language/backend/s3)
- [terraform state command](https://developer.hashicorp.com/terraform/cli/commands/state)
- [terraform import](https://developer.hashicorp.com/terraform/cli/commands/import)

## 🎉 What's next
Now that state makes sense, head to **`terraform-workspaces.md`** to learn how to manage multiple environments (dev/staging/prod) without duplicating your entire codebase.
