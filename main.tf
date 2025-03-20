terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.45.0"
    }
  }
}

# Variables
variable "tfe_hostname" {
  description = "The hostname of your Terraform Enterprise instance"
  type        = string
  default     = "next-parrot.stephen-bui.sbx.hashidemos.io"
}

variable "workspace_access" {
  description = "Workspace access permissions for the team"
  type = object({
    state_versions = optional(string, "none")
    sentinel_mocks = optional(string, "none")
    runs           = optional(string, "read")
    variables      = optional(string, "none")
    workspace_locking = optional(bool, false)
    run_tasks      = optional(bool, false)
  })
  default = {
    state_versions = "read"
    sentinel_mocks = "none"
    runs           = "apply"
    variables      = "write"
    workspace_locking = true
    run_tasks      = true
  }
}

# Configure the Terraform Enterprise provider
provider "tfe" {
  # You'll need to set these environment variables:
  # TFE_TOKEN - Your Terraform Enterprise API token
  # TFE_HOSTNAME - Your Terraform Enterprise hostname
}

# Create a team
resource "tfe_team" "team" {
  name         = "test-team-custom"
  organization = "test-org"
  visibility   = "secret"
}

# Create a team token
resource "tfe_team_token" "team_token" {
  team_id = tfe_team.team.id
}

# Create a workspace for random tests
resource "tfe_workspace" "random_test" {
  name         = "random-test-workspace"
  organization = "test-org"
  auto_apply   = true
}

# Create team access to the workspace with read-only permissions
resource "tfe_team_access" "team_access" {
  team_id      = tfe_team.team.id
  workspace_id = tfe_workspace.random_test.id

  permissions {
    state_versions = var.workspace_access.state_versions
    sentinel_mocks = var.workspace_access.sentinel_mocks
    runs           = var.workspace_access.runs
    variables      = var.workspace_access.variables
    workspace_locking = var.workspace_access.workspace_locking
    run_tasks      = var.workspace_access.run_tasks
  }
}

# Outputs
output "team_token" {
  description = "The API token for the team. Use this token to authenticate with Terraform Enterprise."
  value       = tfe_team_token.team_token.token
  sensitive   = true
}

output "tfe_hostname" {
  description = "The hostname of the Terraform Enterprise instance"
  value       = var.tfe_hostname
}

output "workspace_url" {
  description = "The URL to access the random test workspace in Terraform Enterprise"
  value       = "https://${var.tfe_hostname}/app/${tfe_workspace.random_test.organization}/${tfe_workspace.random_test.name}"
}

output "token_retrieval_instructions" {
  description = "Instructions for retrieving the team token"
  value = <<EOT
To retrieve the team token, run:
  terraform output -raw team_token

This will display the token in plain text. You can then use this token to authenticate with Terraform Enterprise.
EOT
} 