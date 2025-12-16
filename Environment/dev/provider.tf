terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.54.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
terraform {
  backend "azurerm" {
    resource_group_name  = "b17g30"           
    storage_account_name = "b17g30stg"         
    container_name       = "cicdcontainer"         
    key                  = "dev.terraform.tfstate" 
    use_oidc             = true
  }
}
provider "azurerm" {
  features {}
  use_oidc = true
}
provider "random" {}
