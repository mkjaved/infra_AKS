data "azurerm_resource_group" "rg" {
  for_each = var.g18_ra
  name     = each.value.resource_group_name
}
data "azurerm_virtual_network" "vnet" {
  for_each            = var.g18_ra
  name                = each.value.vnet_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_application_gateway" "appgw" {
  for_each            = var.g18_ra
  name                = each.value.appgw_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_user_assigned_identity" "ingress" {
  for_each            = var.g18_ra
  name                = each.value.ingress_appgw
  resource_group_name = each.value.resource_group_name
}
data "azurerm_container_registry" "ACR" {
  for_each            = var.g18_ra
  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_kubernetes_cluster" "K8s" {
  for_each            = var.g18_ra
  name                = each.value.cluster_name
  resource_group_name = each.value.resource_group_name
}
# Role assignments
resource "azurerm_role_assignment" "ra1" {
  for_each             = var.g18_ra
  scope                = data.azurerm_resource_group.rg[each.key].id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_user_assigned_identity.ingress[each.key].principal_id
}

resource "azurerm_role_assignment" "ra2" {
  for_each             = var.g18_ra
  scope                = data.azurerm_virtual_network.vnet[each.key].id
  role_definition_name = "Network Contributor"
  principal_id         = data.azurerm_user_assigned_identity.ingress[each.key].principal_id
}

resource "azurerm_role_assignment" "ra3" {
  for_each             = var.g18_ra
  scope                = data.azurerm_application_gateway.appgw[each.key].id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_user_assigned_identity.ingress[each.key].principal_id
}

resource "azurerm_role_assignment" "ra4" {
  for_each             = var.g18_ra
  principal_id                     = data.azurerm_kubernetes_cluster.K8s[each.key].kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.ACR[each.key].id
  skip_service_principal_aad_check = true
  
}