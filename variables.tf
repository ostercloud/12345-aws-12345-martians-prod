variable "aws_region" {
  default = ""
}

variable "account_ids" {
  default = ""
}

variable "environmnet" {
  default = "${terraform.workspace}"
}
