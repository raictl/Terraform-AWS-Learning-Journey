# Terraform Commands 🖥️

## 📖 Overview
Terraform ships as a single binary with a handful of subcommands. Once you know the core dozen, you can operate almost any Terraform project. This guide walks through the commands you'll use daily, what they actually do under the hood, and how to avoid the mistakes beginners commonly make with them.

## 🎯 Objective
By the end of this doc, you should be able to confidently take a Terraform configuration from "just written" to "safely applied in AWS" using only the CLI — without needing to look up basic syntax every time.

## 🧠 What you'll learn
- The core Terraform workflow: `init` → `plan` → `apply` → `destroy`
- Commands for inspecting and debugging your config (`validate`, `fmt`, `show`, `output`)
- Targeted operations (`-target`, `-var`, `-var-file`)
- Provider and module management commands
- How to safely tear down infrastructure without surprises

## 📝 Step-by-step instructions

### 1. `terraform init`
Run this first, every time, in a new or cloned Terraform directory.

```bash
terraform init
```

**What it actually does:**
- Downloads the provider plugins your config references (e.g. the AWS provider)
- Sets up the backend (where your state file lives — local disk by default)
- Downloads any modules you've referenced

Think of `init` like `npm install` or `pip install -r requirements.txt` — it's the "get my dependencies" step, not the "do the thing" step.

📸 *Screenshot placeholder: terminal output of `terraform init` showing provider download*

### 2. `terraform fmt`
```bash
terraform fmt
```
Auto-formats your `.tf` files to the canonical style (consistent indentation, alignment). Run this before every commit — it's a zero-risk command that makes your code look professional and diffs clean.

Use `terraform fmt -recursive` to format every `.tf` file in nested subdirectories at once.

### 3. `terraform validate`
```bash
terraform validate
```
Checks your configuration for syntax errors and internal consistency (e.g. referencing a variable that doesn't exist). This does **not** talk to AWS — it's a purely local, offline check. Run it right after `fmt` and before `plan`.

### 4. `terraform plan`
```bash
terraform plan
```
This is Terraform's "dry run." It compares your `.tf` files against the current state file and tells you exactly what it *would* do — without doing it.

Read the plan output like a diff:
- `+` means resource will be **created**
- `-` means resource will be **destroyed**
- `~` means resource will be **updated in place**
- `-/+` means resource will be **destroyed and recreated** (a bigger deal than an in-place update — pay attention to this one)

📸 *Screenshot placeholder: `terraform plan` output showing a `+` create and a `~` update*

Save a plan to a file so what you `apply` later is guaranteed to be exactly what you reviewed:
```bash
terraform plan -out=tfplan
```

### 5. `terraform apply`
```bash
terraform apply
```
Executes the plan. Terraform will show you the plan again and ask for a typed `yes` confirmation before touching real infrastructure.

If you saved a plan file, apply that exact plan (safer — no chance of drift between plan and apply):
```bash
terraform apply tfplan
```

Skip the interactive prompt (use carefully, mainly in CI pipelines):
```bash
terraform apply -auto-approve
```

### 6. `terraform destroy`
```bash
terraform destroy
```
Tears down every resource Terraform is tracking in state. Terraform shows a plan of everything to be deleted and asks for confirmation, same as `apply`.

Destroy a single resource instead of everything:
```bash
terraform destroy -target=aws_instance.web
```

### 7. `terraform output`
```bash
terraform output
```
Prints the values of any `output` blocks in your config (e.g. a load balancer's DNS name). Useful for grabbing values to feed into scripts:
```bash
terraform output -raw instance_public_ip
```

### 8. `terraform show`
```bash
terraform show
```
Prints a human-readable summary of the current state file — every resource Terraform currently manages and its attributes.

### 9. `terraform providers`
```bash
terraform providers
```
Lists every provider your configuration depends on, including ones pulled in transitively by modules.

### 10. Passing variables
Three ways to feed values into your config, in order of how often you'll use them:
```bash
# Inline flag (good for one-off overrides)
terraform apply -var="instance_type=t3.micro"

# Variable file (good for environment-specific configs)
terraform apply -var-file="prod.tfvars"

# Environment variable (good for secrets/CI)
export TF_VAR_db_password="..."
```

## ✅ Verification
After running `apply`, confirm success by:
1. Checking the CLI output ends with `Apply complete! Resources: X added, Y changed, Z destroyed.`
2. Running `terraform show` to confirm the resource exists in state
3. Cross-checking in the AWS Console that the resource actually exists

📸 *Screenshot placeholder: AWS Console showing a resource that matches `terraform show` output*

## ❗ Common errors and fixes

| Error | Cause | Fix |
|---|---|---|
| `Error: Inconsistent dependency lock file` | Provider versions changed since last `init` | Run `terraform init -upgrade` |
| `Error acquiring the state lock` | A previous `apply` crashed or is still running elsewhere | Run `terraform force-unlock <LOCK_ID>` only after confirming no other process is actually running |
| `No configuration files found` | Ran a command outside your `.tf` directory | `cd` into the correct directory |
| Plan shows unexpected `-/+` (destroy + recreate) | You changed an attribute that forces replacement (e.g. AMI ID on some resources) | Check the provider docs for which attributes are "ForceNew"; consider `create_before_destroy` lifecycle rule |
| `Error: Provider produced inconsistent final plan` | Provider bug or resource with server-side computed values | Re-run `plan`/`apply`; if persistent, pin an older provider version |

## 💡 Best practices
- Always run `plan` before `apply` — never skip straight to `apply` even on "small" changes.
- Never run `-auto-approve` against production by hand; reserve it for CI pipelines with their own review gates.
- Commit `.terraform.lock.hcl` to version control so everyone on the team uses identical provider versions.
- Keep `.tfvars` files with secrets out of git — add them to `.gitignore`.

## 🛡️ Security tips
- Never hardcode AWS access keys in `.tf` files. Use environment variables, an AWS credentials profile, or an IAM role.
- Treat your state file as sensitive — it often contains plaintext secrets (see `terraform-state.md`).
- Review `plan` output carefully for any `-/+` on resources like databases — an accidental recreate can mean data loss.

## 📚 Official documentation links
- [Terraform CLI Commands](https://developer.hashicorp.com/terraform/cli/commands)
- [terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [terraform apply](https://developer.hashicorp.com/terraform/cli/commands/apply)
- [terraform destroy](https://developer.hashicorp.com/terraform/cli/commands/destroy)

## 🎉 What's next
Now that you're comfortable with the day-to-day commands, move on to **`terraform-state.md`** to understand what's actually happening behind the scenes every time you run `plan` or `apply` — the state file.
