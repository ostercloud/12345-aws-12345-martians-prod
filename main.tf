provider "aws" {
  version             = "~> 0.1"
  allowed_account_ids = "${var.account_ids}"
  region              = "${aws_region}"
}

terraform {
  backend "s3" {
    bucket  = "martian-prod-tfstate"
    key     = "terraform.tfstate"
    encrypt = "true"
  }
}


