resource "azurerm_network_security_group" "nsg" {
  for_each = var.g18_nsg
  name=each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  security_rule {
    name                       = "rule-101"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}