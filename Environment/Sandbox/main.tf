module "g18_rg_module" {
  source = "../../Module/ResourceGroup"
  g18_rg = var.g18_rg
}
module "g18_vnet_module" {
  source     = "../../Module/Networking"
  g18_vnet   = var.g18_vnet
  depends_on = [module.g18_rg_module]
}
module "g18_subnet_module" {
  source     = "../../Module/Subnet"
  g18_subnet = var.g18_subnet
  depends_on = [module.g18_vnet_module]

}
module "g18_public_ip_module" {
  source        = "../../Module/PublicIP"
  g18_public_ip = var.g18_public_ip
  depends_on    = [module.g18_rg_module]
}
module "g18_nic_module" {
  source     = "../../Module/NetworkInterface"
  g18_nic    = var.g18_nic
  depends_on = [module.g18_subnet_module, module.g18_public_ip_module]

}
module "g18_vml_module" {
  source       = "../../Module/VirtualMachineLinux"
  g18_vm_linux = var.g18_vm_linux
  depends_on   = [module.g18_nic_module]
}
# module "g18_vmw_module" {
#   source        = "../../Module/VirtualMachineWindow"
#   g18_vm_window = var.g18_vm_window
#   depends_on    = [module.g18_nic_module]
# }
module "g18_nsg_module" {
  source     = "../../Module/NSG"
  g18_nsg    = var.g18_nsg
  depends_on = [module.g18_rg_module, module.g18_vml_module]
}
module "g18_nisga_module" {
  source     = "../../Module/NISGA"
  g18_nisga  = var.g18_nisga
  depends_on = [module.g18_nic_module, module.g18_nsg_module]
}
module "g18_server_module" {
  source     = "../../Module/Server"
  g18_server = var.g18_server
  depends_on = [module.g18_rg_module]
}
module "g18_db_module" {
  source     = "../../Module/Database"
  g18_db     = var.g18_db
  depends_on = [module.g18_server_module]
}
