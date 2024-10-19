# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.6.0"
    }
  }

  # Configure Terraform Cloud as the backend
  cloud {
    organization = "dark-contoso"
    workspaces {
      name = "blog-az-private-frontdoor"
    }
  }

  required_version = ">= 1.1.0"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
