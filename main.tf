provider "aws" {
  allowed_account_ids = "${var.account_ids}"
  region              = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket  = "martian-prod-tfstate"
    key     = "terraform.tfstate"
    encrypt = "true"
  }
}

module "base_network" {
  source = "./base-network"

  environment              = "${var.environment}"
  name                     = "${var.environment}"
  availability_zones_count = "2"
  instance_tenancy         = "default"
  vpc_cidr_range           = "10.100.0.0/16"
  public_subnets           = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnets          = ["10.100.101.0/24", "10.100.102.0/24"]
}
