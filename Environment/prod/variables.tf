variable "g18_rg" {
  type = map(object(
    {
      name     = string
      location = string
      tags     = optional(map(string))
    }
  ))
}

# variable "g18_vnet" {
#   type = map(any)
# }
# variable "g18_subnet" {
#   type = map(any)
# }
variable "g18_network" {
  type = map(any)
}
variable "g18_stg" {
  type = map(object(
    {
      name                     = string
      virtual_network_name     = string
      resource_group_name      = string
      name_stg                 = string
      location                 = string
      account_tier             = string
      account_replication_type = string
      tags                     = optional(map(string))
      network_rules = map(object({
        default_action = string
        ip_rules       = list(string)
      }))
    }
  ))
}
# variable "g18_sub" {
#   type = map(any)
# }
variable "g18_public_ip" {
  type = map(any)
}
variable "g18_kv" {
  type = map(any)
}
variable "g18_vm_linux" {
  type = map(any)
}
# variable "g18_vm_window" {
#   type = map(any)
# }
variable "g18_nsg" {
  type = map(any)
}
variable "g18_nisga" {
  type = map(any)
}
variable "g18_bastion" {
  type = map(any)
}
# variable "g18_server" {
#   type = map(any)
# }
# variable "g18_db" {
#   type = map(any)

# }
variable "g18_appgw" {
  type = map(any)
}
variable "g18_aks" {
  type = map(any)
}
variable "g18_ra" {
  type = map(any)
}