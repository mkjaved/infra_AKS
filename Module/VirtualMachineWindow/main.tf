# resource "azurerm_windows_virtual_machine" "window" {
#   for_each              = var.g18_vm_window
#   name                  = each.value.name
#   resource_group_name   = each.value.resource_group_name
#   location              = each.value.location
#   size                  = each.value.size
#   admin_username        = each.value.admin_username
#   admin_password        = each.value.admin_password
#   network_interface_ids = each.value.network_interface_ids

#   os_disk {
#     caching              = each.value.os_disk.caching
#     storage_account_type = each.value.os_disk.storage_account_type
#   }

#   source_image_reference {
#     publisher = each.value.source_image_reference.publisher
#     offer     = each.value.source_image_reference.offer
#     sku       = each.value.source_image_reference.sku
#     version   = each.value.source_image_reference.version
#   }
# }
