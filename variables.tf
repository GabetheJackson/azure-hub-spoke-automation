variable "location" {
  type        = string
  default     = "East US"
  description = "The Azure region where all resources will be deployed."
}

variable "resource_group_name" {
  type        = string
  default     = "rg-enterprise-networking-prod"
  description = "The name of our resource group."
}

