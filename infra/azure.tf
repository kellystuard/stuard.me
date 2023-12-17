resource "azurerm_resource_group" "root" {
  name     = "stuard-me"
  location = var.azure_location
}

resource "azurerm_static_site" "root" {
  name                = "root"
  resource_group_name = azurerm_resource_group.root.name
  location            = azurerm_resource_group.root.location
}

resource "azurerm_static_site_custom_domain" "root" {
  static_site_id  = azurerm_static_site.root.id
  domain_name     = cloudflare_zone.stuard_me.zone
  validation_type = "dns-txt-token"
}