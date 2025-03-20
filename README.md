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
- A Terraform Enterprise organization named "test-org" exists
- Admin access to the "test-org" organization
- The TFE hostname is accessible from your environment

## Configuration

### Team Configuration
- Team Name: `test-team-custom`
- Organization: `test-org`
- Visibility: `secret`

### Workspace Configuration
- Name: `random-test-workspace`
- Organization: `test-org`
- Auto-apply: Enabled

### Team Permissions
The team has the following permissions on the workspace:
- State Versions: Read
- Sentinel Mocks: None
- Runs: Apply
- Variables: Write
- Workspace Locking: Enabled
- Run Tasks: Enabled

## Usage

1. Login to your Terraform Enterprise instance:
   ```bash
   terraform login <TFE_HOSTNAME>
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
- The team token should be rotated periodically for security
- Consider using a secrets management solution for storing the team token in production

## Testing

The workspace configuration includes a test that:
1. Creates random pet names
2. Generates random strings
3. Maps pet names to their corresponding strings
4. Updates on every apply to verify functionality

## Contributing

1. Create a new branch for your changes
2. Make your changes
3. Test the configuration
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 