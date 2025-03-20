terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.50.0"
    }
  }
}

# Configure the Terraform Enterprise provider
provider "tfe" {
  hostname = var.tfe_hostname
}

module "team_token" {
  source = "./modules/team-token"

  organization_name  = var.organization_name
  team_name         = var.team_name
  team_visibility   = var.team_visibility
  workspace_name    = var.workspace_name
  workspace_access  = var.workspace_access
  workspace_auto_apply = var.workspace_auto_apply
  tfe_hostname      = var.tfe_hostname
} 