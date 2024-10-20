include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/microsoft.resources/rg"
}

inputs = {
  rgName = "rg-dev-corp-app1-westeurope"
  rgLocation = "West Europe"
  rgTags = {
    environment = "Development"
    org = "corp"
    application = "app1"
    region = "westeurope"
  }
}
