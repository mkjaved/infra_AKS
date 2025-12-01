data "azurerm_subnet" "appgwsubnet" {
    for_each = var.g18_appgw
   name                 = each.value.appgw_subnet_name
   virtual_network_name = each.value.virtual_network_name
   resource_group_name  = each.value.resource_group_name
 }
data "azurerm_public_ip" "pip" {
   for_each = var.g18_appgw 
  name                = each.value.appgw_public_ip_name
  resource_group_name = each.value.resource_group_name
}
resource "azurerm_application_gateway" "appgw" {
    for_each = var.g18_appgw
   name                = each.value.name
   resource_group_name = each.value.resource_group_name
   location            = each.value.location

   sku {
     name     = each.value.sku_name
     tier     = each.value.tier
     capacity = each.value.capacity
   }

   gateway_ip_configuration {
     name      = each.value.appgw_ip_config
     subnet_id = data.azurerm_subnet.appgwsubnet[each.key].id
   }

   frontend_port {
     name = each.value.frontend_port_name
     port = 80
   }

   frontend_ip_configuration {
     name                 = each.value.frontend_ip_configuration_name
     public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
   }

   backend_address_pool {
     name = each.value.backend_address_pool_name
   }

   backend_http_settings {
     name                  = each.value.http_setting_name
     cookie_based_affinity = "Disabled"
     port                  = 80
     protocol              = "Http"
     request_timeout       = 1
   }

   http_listener {
     name                           = each.value.listener_name
     frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
     frontend_port_name             = each.value.frontend_port_name
     protocol                       = "Http"
   }

   request_routing_rule {
     name                       = each.value.request_routing_rule_name
     priority                   = 1
     rule_type                  = "Basic"
     http_listener_name         = each.value.listener_name
     backend_address_pool_name  = each.value.backend_address_pool_name
     backend_http_settings_name = each.value.http_setting_name
   }

   # Since this sample is creating an Application Gateway 
   # that is later managed by an Ingress Controller, there is no need 
   # to create a backend address pool (BEP). However, the BEP is still 
   # required by the resource. Therefore, "lifecycle:ignore_changes" is 
   # used to prevent TF from managing the gateway.
   lifecycle {
     ignore_changes = [
       tags,
       backend_address_pool,
       backend_http_settings,
       http_listener,
       probe,
       request_routing_rule,
     ]
   }
 }