[![CircleCI](https://circleci.com/gh/ostercloud/12345-aws-12345-martians-prod.svg?style=svg)](https://circleci.com/gh/ostercloud/12345-aws-12345-martians-prod)
# Martian Co
Making planets more betters. 

## Usage
This is a demo repo for training purposes. The prefered method of using this repo is to fork it so that you can edit and modify as you see fit. 

## Setup
You will need to have an up to date installation of Terrafrom before you begin working with this repo. Download and install it from here: https://www.terraform.io/downloads.html

## AWS Credentials
In order for this repo to function, you must export your AWS account credentials as environment variables:
```
export AWS_ACCESS_KEY_ID={your AWS Key here}
export AWS_SECRET_ACCESS_KEY={your AWS Secret here}
export AWS_SESSION_TOKEN={your AWS Session Token here}
```
You will need to modify the AWS Region and the allowed AWS account in the variables.tf file:
```
variable "aws_region" {
  default = ""
}

variable "account_ids" {
  default = ""
}
```
## Configuring Remote State
This repo also configures a remote backedn for state storage in S3. YOu will need to perform the following steps before preforming a the `terraform init` command. 

Create an s3 bucket using the bucket name found in the terraform config block:
```
terraform {
  backend "s3" {
    bucket  = "martian-prod-tfstate"
    key     = "terraform.tfstate"
    encrypt = "true"
  }
}
```
the default in this repo is `martian-prod-tfstate`. Enabling Encryption ont he bucket is highly recomended. 

## Initialize
After setting your credentials and creating the s3 bucket in your AWS Account, you should be able to initialize your terraform repo. 
Run `terraform init`
You should be prompted to enter information that was excluded from the terraform configuration block, thi will include the AWS Region that you would like to use for the terraform backend (where your state file is located). 

After that initialization is complete, you should be ready to begin working with terraform!
