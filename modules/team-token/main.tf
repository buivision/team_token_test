terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.50.0"
    }
  }
}

resource "tfe_team" "team" {
  name         = var.team_name
  organization = var.organization_name
  visibility   = var.team_visibility
}

resource "tfe_team_token" "team_token" {
  team_id = tfe_team.team.id
}

resource "tfe_workspace" "workspace" {
  name         = var.workspace_name
  organization = var.organization_name
  auto_apply   = var.workspace_auto_apply
}

resource "tfe_team_access" "team_access" {
  team_id      = tfe_team.team.id
  workspace_id = tfe_workspace.workspace.id

  permissions {
    state_versions = var.workspace_access.state_versions
    sentinel_mocks = var.workspace_access.sentinel_mocks
    runs           = var.workspace_access.runs
    variables      = var.workspace_access.variables
    workspace_locking = var.workspace_access.workspace_locking
    run_tasks      = var.workspace_access.run_tasks
  }
} 