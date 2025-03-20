variable "organization_name" {
  description = "The name of the Terraform Enterprise organization"
  type        = string
  default     = "test-org"
}

variable "team_name" {
  description = "The name of the team to create"
  type        = string
  default     = "test-team-custom"
}

variable "team_visibility" {
  description = "The visibility of the team (secret or organization)"
  type        = string
  default     = "secret"
}

variable "workspace_name" {
  description = "The name of the workspace to create"
  type        = string
  default     = "random-test-workspace"
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

variable "workspace_auto_apply" {
  description = "Whether to enable auto-apply on the workspace"
  type        = bool
  default     = true
}

variable "tfe_hostname" {
  description = "The hostname of the Terraform Enterprise instance"
  type        = string
  default     = "next-parrot.stephen-bui.sbx.hashidemos.io"
} 