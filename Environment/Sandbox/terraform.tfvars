#Resource_Group_Assignment
g18_rg = {
  rg1 = {
    name     = "rg101"
    location = "southafricanorth"
  }
  # rg2 = {
  #   name     = "rg102"
  #   location = "southafricanorth"
  # }

}
#Storage_Account_Assignment
# g18_stg = {
#   stg1 = {
#     name                     = "storage101"
#     resource_group_name      = "rg101"
#     location                 = "southafricanorth"
#     account_tier             = "Standard"
#     account_replication_type = "LRS"
#   }
#   stg2 = {
#     name                     = "storage102"
#     resource_group_name      = "rg102"
#     location                 = "southafricanorth"
#     account_tier             = "Standard"
#     account_replication_type = "GRS"
#   }
# }
#Virtual_Network_Assignment
g18_vnet = {
  vnet1 = {
    name                = "vnet-101"
    resource_group_name = "rg101"
    location            = "southafricanorth"
    address_space       = ["10.10.0.0/16"]
  }
  # vnet2 = {
  #   name                = "vnet-102"
  #   resource_group_name = "rg102"
  #   location            = "southafricanorth"
  #   address_space       = ["10.20.0.0/16"]
  # }
}
#Subnet_Assignment
g18_subnet = {
  subnet1 = {
    name                 = "frontend-101"
    resource_group_name  = "rg101"
    virtual_network_name = "vnet-101"
    address_prefixes     = ["10.10.0.0/24"]
  }
  subnet2 = {
    name                 = "backend-101"
    resource_group_name  = "rg101"
    virtual_network_name = "vnet-101"
    address_prefixes     = ["10.10.1.0/24"]
  }
}

#Public_IP_Assignment
g18_public_ip = {
  public_ip1 = {
    name                = "public-101"
    resource_group_name = "rg101"
    location            = "southafricanorth"
    allocation_method   = "Dynamic"

  }
  public_ip2 = {
    name                = "public-102"
    resource_group_name = "rg101"
    location            = "southafricanorth"
    allocation_method   = "Dynamic"

  }
}

#Network_Interface_Assignment
g18_nic = {
  nic1 = {
    name                = "nic101"
    location            = "southafricanorth"
    resource_group_name = "rg101"
    ip_configuration = {
      name                          = "frontendip"
      subnet_id                     = "/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/virtualNetworks/vnet-101/subnets/frontend-101"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = "/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/publicIPAddresses/public-101"
    }
  }
  nic2 = {
    name                = "nic102"
    location            = "southafricanorth"
    resource_group_name = "rg101"
    ip_configuration = {
      name                          = "backendip"
      subnet_id                     = "/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/virtualNetworks/vnet-101/subnets/backend-101"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = "/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/publicIPAddresses/public-102"
    }
  }
}
#Virtual_Machine_Linux_Assignment  
g18_vm_linux = {
  vm1 = {

    name                = "frontend"
    resource_group_name = "rg101"
    location            = "southafricanorth"
    size                = "Standard_DS1_v2"
    admin_username      = "feadminuser"
    admin_password      = "Password123!"
    # custom_data           = each.value.custom_data
    network_interface_ids           = ["/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/networkInterfaces/nic101"]
    disable_password_authentication = false
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "ubuntu-24_04-lts"
      sku       = "server"
      version   = "latest"
    }
  }

  vm2 = {

    name                = "backend"
    resource_group_name = "rg101"
    location            = "southafricanorth"
    size                = "Standard_DS1_v2"
    admin_username      = "beadminuser"
    admin_password      = "Password123!"
    # custom_data           = each.value.custom_data
    network_interface_ids           = ["/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/networkInterfaces/nic102"]
    disable_password_authentication = false
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
  }
}

# #Virtual_Machine_Window_Assignment  
# g18_vm_window = {
#   vm1 = {
#     name                  = "firstwindowvm"
#     resource_group_name   = "rg101"
#     location              = "southafricanorth"
#     size                  = "Standard_F2"
#     admin_username        = "adminuser"
#     admin_password        = "Password123!"
#     network_interface_ids = ["/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/networkInterfaces/nic101"]

#     os_disk = {
#       caching              = "ReadWrite"
#       storage_account_type = "Standard_LRS"
#     }

#     source_image_reference = {
#       publisher = "MicrosoftWindowsServer"
#       offer     = "WindowsServer"
#       sku       = "2016-Datacenter"
#       version   = "latest"
#     }
#   }
# }
#NSG_Assignment  
g18_nsg = {
  nsg1 = {
    name                = "nsg-101"
    resource_group_name = "rg101"
    location            = "southafricanorth"
  }
  nsg2 = {
    name                = "nsg-102"
    resource_group_name = "rg101"
    location            = "southafricanorth"
  }
}
#NISGA_Assignment
g18_nisga = {
  nisg1 = {
    network_interface_id      = "/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/networkInterfaces/nic101"
    network_security_group_id = "/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/networkSecurityGroups/nsg-101"
  }
  nisg2 = {
    network_interface_id      = "/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/networkInterfaces/nic102"
    network_security_group_id = "/subscriptions/e6da1e06-07a9-4adf-9503-3a37cffb50bb/resourceGroups/rg101/providers/Microsoft.Network/networkSecurityGroups/nsg-102"
  }
}


#DB_Server_Assignment  
g18_server = {
  serv1 = {
    name                         = "server-101"
    resource_group_name          = "rg101"
    location                     = "southafricanorth"
    version                      = "12.0"
    administrator_login          = "dbadmin"
    administrator_login_password = "Password123!"
  }
}
#DB_mySQL_Assignment  
g18_db = {
  db1 = {
    name                = "db101"
    resource_group_name = "rg101"
    location            = "southafricanorth"
    server_name         = "server-101"
  }
}
