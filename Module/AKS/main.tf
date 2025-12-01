data "azurerm_subnet" "kubesubnet" {
  for_each             = var.g18_aks
  name                 = each.value.aks_subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_application_gateway" "appgw" {
  for_each = var.g18_aks
  name                = each.value.appgw_name
  resource_group_name = each.value.resource_group_name
}
resource "azurerm_user_assigned_identity" "aks" {
  for_each            = var.g18_aks
  name                = each.value.UAI_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
}

# AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  for_each                          = var.g18_aks
  name                              = each.value.aks_cluster_name
  location                          = each.value.location
  resource_group_name               = each.value.resource_group_name
  dns_prefix                        = each.value.dns_prefix
  private_cluster_enabled           = each.value.private_cluster_enabled
  role_based_access_control_enabled = each.value.role_based_access_control_enabled
  sku_tier                          = each.value.sku_tier
  tags                              = each.value.tags != null ? each.value.tags : {}

  default_node_pool {
    name            = each.value.pool_name
    node_count      = each.value.node_count
    vm_size         = each.value.vm_size
    os_disk_size_gb = each.value.os_disk_size
    max_pods        = 100
    vnet_subnet_id  = data.azurerm_subnet.kubesubnet[each.key].id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks[each.key].id]
  }


  network_profile {
    network_plugin = "azure"
    dns_service_ip = each.value.dns_service_ip
    service_cidr   = each.value.service_cidr
  }

  ingress_application_gateway {
    gateway_id = data.azurerm_application_gateway.appgw[each.key].id
  }

}
