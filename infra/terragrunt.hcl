locals {
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  area_vars = read_terragrunt_config(find_in_parent_folders("area.hcl"))
  level_vars = read_terragrunt_config(find_in_parent_folders("level.hcl"))
}

remote_state {
  backend = "azurerm"
  config = {
    subscription_id    = "61de5036-4b92-424d-9c58-16720e561d6e"
    resource_group_name  = "rg-dev-corp-demo1-state-eastus"
    storage_account_name = "stodevcorpdemo1state"
    container_name       = "tf-env-states"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}


terraform {
  # Force Terraform to keep trying to acquire a lock for
  # up to 20 minutes if someone else already has the lock
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()

    arguments = [
      "-lock-timeout=20m"
    ]
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.6.0"
    }
  }

  required_version = ">= 1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id = "61de5036-4b92-424d-9c58-16720e561d6e"
}
EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.region_vars.locals,
  local.level_vars.locals
)
