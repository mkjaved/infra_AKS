
# data "azurerm_key_vault" "acrsecret" {
#   for_each = var.g18_acr
#   name                = each.value.kv_name
#   resource_group_name = each.value.resource_group_name
# }

# resource "random_password" "apass" {
#   for_each         = var.g18_acr
#   length           = 16
#   special          = true
#   override_special = "!#$%&*()-_=+[]{}<>:?"
# }

# resource "azurerm_key_vault_secret" "password" {
#   for_each = var.g18_acr
#   name         = "${each.value.acr_name}-password"
#   value        = random_password.apass[each.key].result
#   key_vault_id = data.azurerm_key_vault.acrsecret[each.key].id
# }

resource "azurerm_container_registry" "acr" {
  for_each = var.g18_acr
  
  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = true
  # admin_username      = each.value.admin_username
  # admin_password      = azurerm_key_vault_secret.password[each.key].value
  tags                = each.value.tags != null ? each.value.tags : {}
  }