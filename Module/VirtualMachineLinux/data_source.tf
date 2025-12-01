#Key Vault using data block
# data "azurerm_key_vault" "secret" {
#   name                = "G18keyvault"
#   resource_group_name = "G18Keyvault-RG"
# }

# data "azurerm_key_vault_secret" "username" {
#   name         = "jusername"
#   key_vault_id = data.azurerm_key_vault.secret.id
# }

# data "azurerm_key_vault_secret" "password" {
#   name         = "jpassword"
#   key_vault_id = data.azurerm_key_vault.secret.id
# }

