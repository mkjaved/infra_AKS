
data "azurerm_subnet" "subnet1" {
  for_each = var.g18_vm_linux
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

# data "azurerm_public_ip" "public" {
#   for_each = var.g18_vm_linux
#   name                = each.value.public_ip_name
#   resource_group_name = each.value.resource_group_name
# }


data "azurerm_key_vault" "secret1" {
  for_each = var.g18_vm_linux
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

resource "random_password" "apass" {
  for_each         = var.g18_vm_linux
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "password" {
  for_each = var.g18_vm_linux
  name         = "${each.value.vm_name}-password"
  value        = random_password.apass[each.key].result
  key_vault_id = data.azurerm_key_vault.secret1[each.key].id
}

resource "azurerm_network_interface" "nic" {
  for_each = var.g18_vm_linux

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_configuration_name
    subnet_id                     = data.azurerm_subnet.subnet1[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    # public_ip_address_id          = data.azurerm_public_ip.public[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "linux" {
  for_each            = var.g18_vm_linux
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = azurerm_key_vault_secret.password[each.key].value
  # user_data             = filebase64("../../Scripts/user_data.sh")
  custom_data                     = filebase64("../../Scripts/cloud_init.yml")
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id]
  disable_password_authentication = each.value.disable_password_authentication

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}

