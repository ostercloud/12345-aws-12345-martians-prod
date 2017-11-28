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
  type    = "list"
  default = ["000000000"]
}
```
You will need to set the `aws_region` to the region where you want to deploy resources, and set the `account_ids` to the account number for the AWS account you will be using. this is a list of ID's and can be set to more than one. This is a security feature that makes sure you dont accidentally apply the wrong terraform config to the wrong account. 
## Configuring Remote State
Prior to working with this repo, I would suggest getting familiar with terraform Remote states if you are note already. More information on them can be found here: [Remote States](./pre-work/01-Remote-States.md)

This repo also configures a remote backedn for state storage in S3. You will need to perform the following steps before preforming a the `terraform init` command. 

Create an s3 bucket using the bucket name configured in the terraform config block:
```
terraform {
  backend "s3" {
    bucket  = "martian-prod-tfstate"
    key     = "terraform.tfstate"
    encrypt = "true"
  }
}
```
the default bucket name in this repo is `martian-prod-tfstate`. Since AWS S3 bucket names are globally unique, you will need to change this to a unique name in your account. **Enabling Encryption and Versioning on the bucket is highly recomended**. 

## Initialize
After setting your credentials and creating the s3 bucket in your AWS Account, you should be able to initialize your terraform repo. 
Run `terraform init`
You should be prompted to enter information that was excluded from the terraform configuration block, this will include the AWS Region that you would like to use for the terraform backend (where your state file is located). 

After that initialization is complete, you should be ready to begin working with terraform!
