resource "azurerm_resource_group" "root" {
  name     = "stuard-me"
  location = var.azure_location
}

resource "azurerm_static_site" "root" {
  name                = "root"
  resource_group_name = azurerm_resource_group.root.name
  location            = azurerm_resource_group.root.location
}

