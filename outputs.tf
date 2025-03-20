output "team_token" {
  description = "The API token for the team"
  value       = module.team_token.team_token
  sensitive   = true
}

output "tfe_hostname" {
  description = "The hostname of the TFE instance"
  value       = module.team_token.tfe_hostname
}

output "workspace_url" {
  description = "The URL to access the workspace"
  value       = module.team_token.workspace_url
} 