resource "azurerm_resource_group" "G18" {
  for_each = var.g18_rg
  name     = each.value.name
  location = each.value.location
  tags     = each.value.tags != null ? each.value.tags : {}

}
# locals {
#   regular_label = {
#     env  = "production"
#     tier = "vm"
#   }
# }

# output "mera_rg" {
#  value = { for k, rg in azurerm_resource_group.G18 : k => rg.id }
# }