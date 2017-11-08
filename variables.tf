variable "aws_region" {
  default = ""
}

variable "account_ids" {
  type = "list"
  default = []
}

variable "environment" {
   default = "martian-prod"
}
