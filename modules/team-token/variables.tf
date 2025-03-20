variable "organization_name" {
  description = "The name of the Terraform Enterprise organization"
  type        = string
}

variable "team_name" {
  description = "The name of the team to create"
  type        = string
}

variable "team_visibility" {
  description = "The visibility of the team (secret or organization)"
  type        = string
  default     = "secret"
}

variable "workspace_name" {
  description = "The name of the workspace to create"
  type        = string
}

variable "workspace_auto_apply" {
  description = "Whether to enable auto-apply on the workspace"
  type        = bool
  default     = true
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
}

variable "tfe_hostname" {
  description = "The hostname of the Terraform Enterprise instance"
  type        = string
} 