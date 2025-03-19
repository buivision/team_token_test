# Terraform Enterprise Team Token and Workspace Setup

This repository contains Terraform configurations to set up a team, generate a team token, and create a workspace in Terraform Enterprise (TFE).

## Project Structure

- `main.tf` - Creates the team, team token, and workspace in TFE
- `workspace_config/` - Contains the workspace configuration
  - `main.tf` - Provider and backend configuration
  - `random_test.tf` - Random resource testing configuration
  - `setup.sh` - Script to initialize and apply the workspace configuration

## Prerequisites

- Terraform installed locally
- Access to a Terraform Enterprise instance
- TFE API token with appropriate permissions

## Usage

1. Set your TFE API token as an environment variable:
   ```bash
   export TF_TOKEN="your-tfe-token"
   ```

2. Apply the parent configuration to create the team and workspace:
   ```bash
   terraform apply
   ```

3. Navigate to the workspace configuration and run the setup script:
   ```bash
   cd workspace_config
   ./setup.sh
   ```

## Outputs

The parent configuration provides:
- `team_token` - The API token for the team
- `tfe_hostname` - The hostname of the TFE instance
- `workspace_url` - The URL to access the workspace

## Security Notes

- The team token is marked as sensitive and should be handled securely
- The `.gitignore` file is configured to exclude sensitive information
- Never commit `.tfvars` files or state files to version control 