output "team_token" {
  description = "The API token for the team"
  value       = tfe_team_token.team_token.token
  sensitive   = true
}

output "tfe_hostname" {
  description = "The hostname of the TFE instance"
  value       = var.tfe_hostname
}

output "workspace_url" {
  description = "The URL to access the workspace"
  value       = "https://${var.tfe_hostname}/app/${var.organization_name}/workspaces/${var.workspace_name}"
} 