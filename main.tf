# Creates the Resource Group
resource "azurerm_resource_group" "network_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Creates the Hub Virtual Network
resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = ["10.0.0.0/16"]
}

# Gateway Subnet inside the Hub
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Management Subnet inside the Hub
resource "azurerm_subnet" "management" {
  name                 = "ManagementSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Creates the Production Spoke Virtual Network
resource "azurerm_virtual_network" "spoke_prod" {
  name                = "vnet-spoke-prod"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = ["10.1.0.0/16"]
}

# Creates the Production Application Subnet inside the Production VNet
resource "azurerm_subnet" "prod_app" {
  name                 = "ProdAppSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.spoke_prod.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Peering from Hub to Production Spoke
resource "azurerm_virtual_network_peering" "hub_to_prod" {
  name                      = "peer-hub-to-prod"
  resource_group_name       = azurerm_resource_group.network_rg.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_prod.id
  allow_virtual_network_access = true
}

# Peering from Production Spoke back to Hub
resource "azurerm_virtual_network_peering" "prod_to_hub" {
  name                      = "peer-prod-to-hub"
  resource_group_name       = azurerm_resource_group.network_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_prod.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
}