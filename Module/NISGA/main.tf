# resource "azurerm_network_security_group" "nsg" {
#   for_each = var.g18_nisga
#   name=each.value.name
#   resource_group_name = each.value.resource_group_name
#   location = each.value.location
#   security_rule {
#     name                       = "rule-101"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

data "azurerm_network_interface" "nic" {
  for_each = var.g18_nisga
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_network_security_group" "nsg" {
  for_each = var.g18_nisga
  name                = each.value.nsg_name
  resource_group_name = each.value.resource_group_name
}
#if we wanna make same child module
# resource "azurerm_network_interface_security_group_association" "nisga" {
#   for_each = var.g18_nisga
#   network_interface_id      = data.azurerm_network_interface.nic[each.key].id
#   network_security_group_id = azurerm_network_security_group.nsg[each.key].id
# }

resource "azurerm_network_interface_security_group_association" "nisga" {
  for_each = var.g18_nisga
  network_interface_id      = data.azurerm_network_interface.nic[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg[each.key].id
}