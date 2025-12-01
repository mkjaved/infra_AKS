resource "azurerm_public_ip" "pip" {
  for_each = var.g18_public_ip
  name = each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  allocation_method = each.value.allocation_method
  sku = each.value.sku
}

