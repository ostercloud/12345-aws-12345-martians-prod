provider "aws" {
  allowed_account_ids = "${var.account_ids}"
  region              = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket  = "bran8120-prod-tfstate"
    key     = "terraform.tfstate"
    encrypt = "true"
  }
}

module "network" {
  source = "base-network"

  name        = "bran8120-BaseNetwork"
  environment = "prod"
}
