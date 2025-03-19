terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "remote" {
    # hostname and organization will be provided via -backend-config
    workspaces {
      name = "random-test-workspace"
    }
  }
} 