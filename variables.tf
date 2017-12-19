variable "aws_region" {
  default = "us-east-1"
}

variable "account_ids" {
  type    = "list"
  default = ["057866020917"]
}

variable "environment" {
  default = "bran8120-prod"
}
