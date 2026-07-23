# Terraform Workspaces 🧩

## 📖 Overview
Workspaces let you use the **same** Terraform configuration to manage **multiple, isolated** sets of infrastructure — each with its own state file. The classic use case is spinning up identical dev/staging/prod environments from one codebase without copy-pasting `.tf` files three times.

## 🎯 Objective
Understand what a workspace actually is under the hood, when to use them, and — just as importantly — when *not* to (this is where a lot of beginners get burned).

## 🧠 What you'll learn
- What a workspace really is (hint: it's simpler than it sounds)
- How to create, switch, and delete workspaces
- How to reference the current workspace inside your `.tf` config
- Why workspaces are not a substitute for separate environments in many real-world setups

## 📝 Step-by-step instructions

### 1. The mental model
By default, every Terraform project has one workspace called `default`. A workspace is really just **a named slot for a separate state file**, using the same configuration code.

Think of it like git branches, but for state instead of code: same files, different "instance" of the tracked data.

```
.terraform/
  terraform.tfstate.d/
    dev/
      terraform.tfstate
    staging/
      terraform.tfstate
    prod/
      terraform.tfstate
```

📸 *Screenshot placeholder: directory tree showing `.terraform/terraform.tfstate.d/` with per-workspace folders*

### 2. Listing and checking your current workspace
```bash
terraform workspace list
```
The workspace with the `*` next to it is the one currently active.

```bash
terraform workspace show
```

### 3. Creating a new workspace
```bash
terraform workspace new dev
```
This creates a brand-new, empty state file for the `dev` workspace and switches you into it immediately.

📸 *Screenshot placeholder: terminal showing `terraform workspace new dev` and the confirmation message*

### 4. Switching between workspaces
```bash
terraform workspace select prod
```
**Important:** switching workspaces does not change your `.tf` files — it only changes which state file Terraform reads and writes to. Your next `plan`/`apply` will operate on whichever workspace is currently selected.

### 5. Using the workspace name inside your config
Terraform exposes the active workspace as a built-in value: `terraform.workspace`. This lets one config file behave differently per environment:

```hcl
resource "aws_instance" "web" {
  instance_type = terraform.workspace == "prod" ? "t3.large" : "t3.micro"

  tags = {
    Environment = terraform.workspace
  }
}
```

### 6. Deleting a workspace
```bash
terraform workspace select default
terraform workspace delete dev
```
You can't delete the workspace you're currently in, and Terraform will refuse to delete a workspace that still has resources tracked in its state — destroy those first.

## ✅ Verification
- `terraform workspace list` shows all expected environments with the correct one marked active
- `terraform state list` after switching workspaces shows a completely different (or empty) resource list, confirming isolation
- Tags/names on real AWS resources correctly reflect `terraform.workspace` (e.g. an instance tagged `Environment = dev`)

📸 *Screenshot placeholder: AWS Console showing two EC2 instances tagged `dev` and `prod`, created from the same config*

## ❗ Common errors and fixes

| Error | Cause | Fix |
|---|---|---|
| Applied to the wrong environment by accident | Forgot to check active workspace before `apply` | Always run `terraform workspace show` before `apply`; consider a pre-apply script that echoes it |
| `Workspace "prod" is not empty` on delete | Resources still tracked in that workspace's state | `terraform destroy` in that workspace first, then delete it |
| Config doesn't visibly differ between workspaces | Forgot to actually use `terraform.workspace` in conditionals | Reference `terraform.workspace` explicitly wherever behavior should vary |
| Same variable values applied to dev and prod despite workspaces | Workspaces don't change *which* `.tfvars` file loads | Combine workspaces with `-var-file=${terraform.workspace}.tfvars` conventions, or avoid workspaces for this case (see Best Practices) |

## 💡 Best practices
- Workspaces are best for **short-lived, near-identical** environments (e.g. ephemeral PR preview environments, per-developer sandboxes) — not for prod vs. dev where configs genuinely diverge (different instance sizes, different modules, different compliance requirements).
- For prod vs. dev with meaningfully different configurations, many teams prefer **separate directories with their own backend config** (`environments/dev/`, `environments/prod/`) over workspaces — this makes accidental cross-environment applies structurally harder, not just a matter of remembering to check.
- Always run `terraform workspace show` as a habit before every `apply` in a multi-workspace setup.
- Name workspaces consistently and predictably (`dev`, `staging`, `prod`) — avoid ad hoc names that no one remembers the purpose of later.

## 🛡️ Security tips
- Workspaces share the same backend credentials and IAM permissions by default — a workspace switch does **not** give you least-privilege isolation between environments. If dev and prod need genuinely different AWS permissions, use separate AWS accounts or roles, not just separate workspaces.
- Double-check `terraform.workspace` before any `destroy` — this is the single most common way people accidentally destroy production.

## 📚 Official documentation links
- [Terraform Workspaces](https://developer.hashicorp.com/terraform/language/state/workspaces)
- [terraform workspace command](https://developer.hashicorp.com/terraform/cli/commands/workspace)

## 🎉 What's next
With state and workspaces covered, wrap up with **`best-practices.md`** for the broader habits (file structure, module design, CI/CD hygiene) that separate a "learning project" from a production-ready Terraform codebase.
