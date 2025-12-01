data "azurerm_subnet" "subnet1" {
  for_each = var.g18_bastion
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
resource "azurerm_public_ip" "pips" {
  for_each = var.g18_bastion
  name                = "bastionpip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_bastion_host" "bastion" {
    for_each = var.g18_bastion
  name                = each.value.name_bastion
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet1[each.key].id
    public_ip_address_id = azurerm_public_ip.pips[each.key].id
  }
}