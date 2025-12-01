data "azurerm_subnet" "subnet1" {
  for_each = var.g18_stg
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_storage_account" "stg" {
  for_each                 = var.g18_stg
  name                     = each.value.name_stg
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags=each.value.tags
dynamic  "network_rules" {
  for_each = each.value.network_rules
    content {
    default_action             = network_rules.value.default_action
    ip_rules                   = network_rules.value.ip_rules
    virtual_network_subnet_ids = [data.azurerm_subnet.subnet1[each.key].id]
    }
  }

}