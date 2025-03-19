#!/bin/bash

# First ensure the parent configuration is applied and has outputs
cd .. && \
if ! terraform output workspace_url >/dev/null 2>&1; then
    echo "Applying parent configuration first..."
    # Get the TFE hostname from the parent configuration
    read -p "Enter your TFE hostname: " TFE_HOSTNAME
    TF_VAR_tfe_hostname="$TFE_HOSTNAME" terraform apply -auto-approve
fi

# Get values from the parent directory's Terraform output
TEAM_TOKEN=$(terraform output -raw team_token) && \
TFE_HOSTNAME=$(terraform output -raw tfe_hostname) && \
WORKSPACE_URL=$(terraform output -raw workspace_url) && \
cd workspace_config

# Extract organization from workspace URL
# URL format: https://<hostname>/app/<organization>/<workspace>
ORG_NAME=$(echo "$WORKSPACE_URL" | cut -d'/' -f5)

# Set environment variables
export TF_TOKEN="$TEAM_TOKEN"
export TF_HOSTNAME="$TFE_HOSTNAME"

echo "Using organization: $ORG_NAME"
echo "Using hostname: $TFE_HOSTNAME"

# Initialize Terraform with remote backend
terraform init \
  -backend-config="hostname=$TFE_HOSTNAME" \
  -backend-config="organization=$ORG_NAME" \
  -backend-config="token=$TEAM_TOKEN" \
  -reconfigure

# Apply the configuration
terraform apply 