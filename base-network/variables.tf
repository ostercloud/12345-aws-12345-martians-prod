# Descriptive name of the Environment to add to tags (should make sense to humans)
variable "environment" {
  type        = "string"
  description = "The Environment this VPC is being deployed into (prod, dev, test, etc)"
}

# Name to give to the VPC and associated resources
variable "name" {
  type        = "string"
  description = "The name of the VPC"
}

# Number of AZs to create
variable "availability_zones_count" {
  default     = "2"
  type        = "string"
  description = "Number of Availability Zones to use"
}

# Instance Tenancy (can be dedicated or default)
variable "instance_tenancy" {
  default     = "default"
  type        = "string"
  description = "VPC Instance Tenancy (single tenant - dedicated, multi-tenancy - default)"
}

# The CIDR Range for the entire VPC
variable "vpc_cidr_range" {
  default     = "172.18.0.0/16"
  type        = "string"
  description = "The IP Address space used for the VPC in CIDR notation."
}

# The CIDR Ranges for the Public Subnets
variable "public_subnets" {
  type        = "list"
  description = "IP Address Ranges in CIDR Notation for Public Subnets in AZ1-3."
  default     = ["172.18.0.0/22", "172.18.4.0/22", "172.18.8.0/22"]
}

# The CIDR Ranges for the Private Subnets
variable "private_subnets" {
  type        = "list"
  default     = ["172.18.32.0/21", "172.18.40.0/21", "172.18.48.0/21"]
  description = "IP Address Ranges in CIDR Notation for Private Subnets in AZ 1-3."
}

# TransitVPC enabled
variable "transit_vpc" {
  default     = "false"
  description = "Enable TransitVPC on this VGW"
}
