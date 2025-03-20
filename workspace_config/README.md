# Workspace Configuration

This directory contains a test workspace configuration that demonstrates how to use a team token for workspace authentication and management in Terraform Enterprise (TFE). It serves as a child configuration that depends on resources created by the parent configuration.

## Purpose

The workspace configuration validates that:
1. Team tokens are properly generated and accessible
2. Workspace permissions are correctly set
3. Auto-apply functionality works as expected
4. Backend configuration is properly handled

## Files

- `setup.sh` - Automated setup script that handles workspace initialization and configuration
- `main.tf` - Provider and backend configuration for the workspace
- `random_test.tf` - Test resources to validate workspace functionality

## Setup Script Details

The `setup.sh` script automates the following process:

1. **Parent Configuration Check**
   - Verifies if parent configuration is applied
   - Prompts for TFE hostname if not already configured
   - Applies parent configuration if needed

2. **Configuration Extraction**
   - Retrieves team token from parent outputs
   - Gets TFE hostname from parent outputs
   - Extracts workspace URL and organization name
   - Validates all required values are present

3. **Environment Setup**
   - Sets required environment variables
   - Configures TFE token and hostname

4. **Terraform Operations**
   - Initializes Terraform with remote backend
   - Configures backend with:
     - Organization name
     - Team token authentication
     - TFE hostname
   - Applies the workspace configuration

## Usage

Simply run the setup script:
```bash
./setup.sh
```

The script will handle all necessary steps including checking the parent configuration and setting up the workspace.

## Error Handling

The script includes:
- Input validation for all required values
- Clear error messages for missing configurations
- Automatic exit on any error (`set -e`)
- Descriptive progress messages

## Security Considerations

- Team tokens are handled securely via environment variables
- No sensitive information is stored in version control
- Backend configuration is dynamic and environment-specific
- All operations use HTTPS for TFE communication

## Expected Behavior

When the script runs successfully:
- The workspace will be configured to use the team token for authentication
- The random resources will be created automatically without manual approval
- This confirms that the team token has the correct permissions for auto-apply

## Outputs

The configuration generates:
- Three random pet names
- Three random strings
- A mapping of pet names to their corresponding random strings

## Security

- The workspace uses the team token for authentication
- All sensitive information is handled via environment variables
- The backend configuration is dynamically set using the parent configuration's outputs 