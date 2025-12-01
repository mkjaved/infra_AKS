resource "azurerm_virtual_network" "vnet_subnet" {
  for_each            = var.g18_network
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space
  
 dynamic "subnet" {
    for_each = each.value.subnets
    content{
    name             = subnet.value.name
    address_prefixes = subnet.value.address_prefixes
    }
  }
}