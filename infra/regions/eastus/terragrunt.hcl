include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/microsoft.resources/rg"
}

inputs = {
  rgName = "rg-dev-corp-app1-eastus"
  rgLocation = "East US"
  rgTags = {
    environment = "Development"
    org = "corp"
    application = "app1"
    region = "eastus"
  }
}
