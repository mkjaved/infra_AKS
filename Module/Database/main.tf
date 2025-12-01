resource "azurerm_sql_database" "database" {
  for_each       = var.g18_db
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  server_name         = each.value.server_name
}
