# Create an Azure Resource Group
resource "azurerm_resource_group" "rg_region_eastus" {
  name     = "rg-dev-corp-app1-eastus"
  location = "East US"
  tags = {
    environment = "Development"
  }
}
