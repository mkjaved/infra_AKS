#Resource_Group_Assignment
g18_rg = {
  # rg1 = {
  #   name     = "tf-sa-dev"
  #   location = "southafricanorth"
  #   tags = {
  #     env  = "dev"
  #     department = "engineering"
  #   }
  # }
  # rg2 = {
  #   name     = "rg102"
  #   location = "southafricanorth"
  # }
  rg3 = {
    name     = "tf-sa-rg-aks"
    location = "southafricanorth"
    tags = {
      env        = "dev"
      department = "engineering"

    }
  }

}

#Virtual_Network_Assignment
# g18_vnet = {
#   vnet1 = {
#     name                = "vnet-101"
#     resource_group_name = "rg101"
#     location            = "southafricanorth"
#     address_space       = ["10.10.0.0/16"]
#   }
# vnet2 = {
#   name                = "vnet-102"
#   resource_group_name = "rg102"
#   location            = "southafricanorth"
#   address_space       = ["10.20.0.0/16"]
# }
# }
#Subnet_Assignment
# g18_subnet = {
#   subnet1 = {
#     name                 = "frontend-101"
#     resource_group_name  = "rg101"
#     virtual_network_name = "vnet-101"
#     address_prefixes     = ["10.10.0.0/24"]
#   }
#   subnet2 = {
#     name                 = "backend-101"
#     resource_group_name  = "rg101"
#     virtual_network_name = "vnet-101"
#     address_prefixes     = ["10.10.1.0/24"]
#   }
#   subnet3 = {
#     name                 = "AzureBastionSubnet"
#     resource_group_name  = "rg101"
#     virtual_network_name = "vnet-101"
#     address_prefixes     = ["10.10.2.0/27"]
#   }
#   subnet4 = {
#     name                 = "AppGateWay"
#     resource_group_name  = "rg101"
#     virtual_network_name = "vnet-101"
#     address_prefixes     = ["10.10.3.0/24"]
#   }
# }

#vnet_sub_Assignment
g18_network = {
  # vnet1 = {
  #   name                = "vnet-101"
  #   resource_group_name = "rg101"
  #   location            = "southafricanorth"
  #   address_space       = ["10.10.0.0/16"]
  #   subnets = {
  #     subnet1 = {
  #       name             = "frontend-101"
  #       address_prefixes = ["10.10.1.0/24"]
  #     }
  #     subnet2 = {
  #       name             = "backend-101"
  #       address_prefixes = ["10.10.2.0/24"]
  #     }
  #   }
  # }
  # vnet2 = {
  #   name                = "vnet-102"
  #   resource_group_name = "rg101"
  #   location            = "southafricanorth"
  #   address_space       = ["10.20.0.0/16"]
  #   subnets = {
  #     subnet1 = {
  #       name             = "subnet1"
  #       address_prefixes = ["10.20.1.0/24"]
  #     }
  #   }
  # }
  vnet3 = {
    name                = "vnet-aks"
    resource_group_name = "tf-sa-rg-aks"
    location            = "southafricanorth"
    address_space       = ["10.10.0.0/16"]
    subnets = {
      subnet1 = {
        name             = "aks_subnet"
        address_prefixes = ["10.10.1.0/24"]
      }
      subnet2 = {
        name             = "appgw_subnet"
        address_prefixes = ["10.10.2.0/24"]
      }
    }
  }

}
# Storage_Account_Assignment
g18_stg = {
  stg_account_1 = {
    name                     = "frontend-101"
    name_stg                 = "storage101"
    resource_group_name      = "rg101"
    virtual_network_name     = "vnet-101"
    location                 = "southafricanorth"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "production"
      department  = "finance"
    }
    network_rules = {
      rule1 = {
        default_action = "Allow"
        ip_rules       = ["192.168.1.1", "10.0.0.0/16"]
      }
    }
  }

  stg_account_2 = {
    name                     = "backend-101"
    name_stg                 = "storageacct2"
    resource_group_name      = "rg102"
    virtual_network_name     = "vnet-102"
    location                 = "southafricanorth"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "development"
      department  = "engineering"
    }
    network_rules = {
      rule1 = {
        default_action = "Deny"
        ip_rules       = ["172.16.0.0/12"]
      }
    }
  }
}
#Public_IP_Assignment
g18_public_ip = {
  #   public_ip1 = {
  #     name                = "public-101"
  #     resource_group_name = "rg101"
  #     location            = "southafricanorth"
  #     allocation_method   = "Dynamic"

  #   }
  #   public_ip2 = {
  #     name                = "public-102"
  #     resource_group_name = "rg101"
  #     location            = "southafricanorth"
  #     allocation_method   = "Dynamic"

  #   }
  public_ip3 = {
    name                = "appgw-pip"
    resource_group_name = "tf-sa-rg-aks"
    location            = "southafricanorth"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

#KeyVault_Assignment 
g18_kv = {
  kv1 = {
    name                = "KeyVaultproject-101"
    location            = "southafricanorth"
    resource_group_name = "tf-sa-rg-aks"
  }
}

#Virtual_Machine_Linux_Assignment  
g18_vm_linux = {
  vm1 = {
    name                 = "frontend-101"
    virtual_network_name = "vnet-101"
    resource_group_name  = "rg101"
    # public_ip_name                  = "public-101"
    kv_name                         = "KeyVaultproject-101"
    nic_name                        = "nic101"
    ip_configuration_name           = "frontendip"
    private_ip_address_allocation   = "Dynamic"
    vm_name                         = "frontend"
    location                        = "southafricanorth"
    size                            = "Standard_DS1_v2"
    admin_username                  = "feadminuser"
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

  vm2 = {
    name                 = "backend-101"
    virtual_network_name = "vnet-101"
    resource_group_name  = "rg101"
    # public_ip_name                  = "public-102"
    kv_name                         = "KeyVaultproject-101"
    nic_name                        = "nic102"
    ip_configuration_name           = "backendendip"
    private_ip_address_allocation   = "Dynamic"
    vm_name                         = "backend"
    location                        = "southafricanorth"
    size                            = "Standard_DS1_v2"
    admin_username                  = "beadminuser"
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
    nsg_name            = "nsg-101"
    resource_group_name = "rg101"
    # location="southafricanorth"
    nic_name = "nic101"

  }
  nisg2 = {
    nsg_name            = "nsg-102"
    resource_group_name = "rg101"
    # location="southafricanorth"
    nic_name = "nic102"
  }
}
#bastion_host
g18_bastion = {
  bastion1 = {
    name                 = "AzureBastionSubnet"
    virtual_network_name = "vnet-101"
    resource_group_name  = "rg101"
    public_ip_name       = "public-103"
    name_bastion         = "bastion-101"
    location             = "southafricanorth"
  }
}
#DB_Server_Assignment  
# g18_server = {
#   serv1 = {
#     name                         = "server-101"
#     resource_group_name          = "rg101"
#     location                     = "southafricanorth"
#     version                      = "12.0"
#     administrator_login          = "dbadmin"
#     administrator_login_password = "Password123!"
#   }
# }
#DB_mySQL_Assignment  
# g18_db = {
#   db1 = {
#     name                = "db101"
#     resource_group_name = "rg101"
#     location            = "southafricanorth"
#     server_name         = "server-101"
#   }
# }
#ACR_Assignment
g18_acr = {
  ACR1 = {
    # kv_name             = "KeyVaultproject-101"
    resource_group_name = "tf-sa-rg-aks"
    acr_name            = "Infrapipelinebg"
    location            = "southafricanorth"
    sku                 = "Standard"
    # admin_username      = "acrservicecon"
    tags = {
      env        = "dev"
      department = "engineering"
    }
  }
}

#AKS_APPGW_Assignment
g18_appgw = {
  appgw1 = {
    appgw_subnet_name              = "appgw_subnet"
    virtual_network_name           = "vnet-aks"
    resource_group_name            = "tf-sa-rg-aks"
    appgw_public_ip_name           = "appgw-pip"
    name                           = "ApplicationGateway1"
    location                       = "southafricanorth"
    sku_name                       = "Standard_v2"
    tier                           = "Standard_v2"
    capacity                       = 1
    appgw_ip_config                = "aks-gateway-ip-configuration"
    frontend_port_name             = "feport"
    frontend_ip_configuration_name = "feip"
    backend_address_pool_name      = "beap"
    http_setting_name              = "be-htst"
    listener_name                  = "httplstn"
    request_routing_rule_name      = "rqrt"
  }
}
#AKS_Cluster_Assignment
g18_aks = {
  "cluster1" = {
    aks_subnet_name                   = "aks_subnet"
    virtual_network_name              = "vnet-aks"
    resource_group_name               = "tf-sa-rg-aks"
    appgw_name                        = "ApplicationGateway1"
    UAI_name                          = "aks-aks-cluster"
    location                          = "southafricanorth"
    aks_cluster_name                  = "aks-cluster"
    dns_prefix                        = "aks-cluster"
    private_cluster_enabled           = "false"
    role_based_access_control_enabled = "false"
    sku_tier                          = "Free"
    tags = {
      env        = "qa"
      department = "engineering"
    }
    pool_name      = "aks1pool"
    node_count     = 1
    vm_size        = "Standard_D2_v2"
    os_disk_size   = "50"
    dns_service_ip = "192.168.0.10"
    service_cidr   = "192.168.0.0/20"
  }
}
# Role assignments
g18_ra = {
  Cluster1_RA = {
    resource_group_name = "tf-sa-rg-aks"
    vnet_name           = "vnet-aks"
    appgw_name          = "ApplicationGateway1"
    ingress_appgw       = "aks-aks-cluster"
    acr_name            = "Infrapipelinebg"
    cluster_name        = "aks-cluster"
  }
}
